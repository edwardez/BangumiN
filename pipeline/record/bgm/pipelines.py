# -*- coding: utf-8 -*-
# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
import datetime
import logging
import os

from scrapy import signals
from scrapy.exporters import CsvItemExporter

from common.RecordTableDatabaseExecutor import RecordTableDatabaseExecutor
from common.WikiHistoryTableDatabaseExecutor import \
    WikiHistoryTableDatabaseExecutor
from models.Record import Record
from models.WikiHistory import WikiHistory

logger = logging.getLogger(__name__)


class TsvPipeline(object):
    def __init__(self):
        self.files = dict()

    @classmethod
    def from_crawler(cls, crawler):
        pipeline = cls()
        crawler.signals.connect(pipeline.spider_opened, signals.spider_opened)
        crawler.signals.connect(pipeline.spider_closed, signals.spider_closed)
        return pipeline

    def spider_opened(self, spider):
        file = open(spider.name + '-' + datetime.datetime.utcnow().strftime(
            "%Y-%m-%dT%H:%M:%S") + '.tsv*',
                    'wb')
        self.files[spider] = file

        self.exporter = CsvItemExporter(file, include_headers_line=True,
                                        join_multivalued=';', encoding="utf-8",
                                        delimiter='\t')
        if spider.name == 'user':
            self.exporter.fields_to_export = ['uid', 'name', 'nickname',
                                              'joindate', 'activedate']
        elif spider.name == 'subject':
            self.exporter.fields_to_export = ['subjectid', 'order',
                                              'subjectname', 'subjecttype',
                                              'rank', 'date',
                                              'votenum', 'favnum', 'staff',
                                              'relations']
        elif spider.name == 'record':
            self.exporter.fields_to_export = ['uid', 'name', 'nickname', 'iid',
                                              'typ', 'state', 'adddate', 'rate',
                                              'tags', 'comment']
        elif spider.name == 'index':
            self.exporter.fields_to_export = ['indexid', 'creator', 'favourite',
                                              'date', 'items']
        elif spider.name == 'friends':
            self.exporter.fields_to_export = ['user', 'friend']
        self.exporter.start_exporting()

    def spider_closed(self, spider):
        self.exporter.finish_exporting()
        file = self.files.pop(spider)
        filename = file.name
        newname = filename[:-5] + '-' + datetime.datetime.utcnow().strftime(
            "%Y-%m-%dT%H:%M:%S") + '.tsv'
        file.close()
        os.rename(filename, newname)

    def process_item(self, item, spider):
        self.exporter.export_item(item)
        return item


class WikiHistoryDBPipeline(object):
    def __init__(self):
        self.commit_threshold = 1000
        self.received_elements_in_this_cycle_count = 0
        self.current_min_user_id = 1  # current min user id in this process cycle
        self.current_max_user_id = 2  # current max user id in this process cycle
        self.wikiHistoryTableDatabaseExecutor = WikiHistoryTableDatabaseExecutor(
            WikiHistory,
            self.commit_threshold)
        self.items_to_process = []
        self.entities_to_create = []
        self.entities_to_update = []
        self.entities_seen = {}  # a nested dict, user_id is the dict ket, each value contains set of subject_id
        self.entities_might_need_deleting = set()  # contains the primary key, tuple of entities, tuple(subject_id,
        # user_id)
        self.stats = {
            'created_entities': 0,
            'updated_entities': 0,
            'skipped_entities': 0,
        }

    def close_spider(self, spider):
        if spider.name != 'wiki':
            return

        # process items that're left(in the last cycle, element won't be )
        self.write_to_db()

        logger.info('Finished scraping, affected rows stats: %s', self.stats)
        logger.info(
            'Note: the stats might not reflect the final database state, i.e. if db is manipulated by another session '
            'at the same time.')
        self.wikiHistoryTableDatabaseExecutor.close_session()

    def process_item(self, item, spider):
        if spider.name != 'wiki':
            return item

        parsed_wiki_history = WikiHistory.parse_input(item)
        self.items_to_process.append(parsed_wiki_history)
        self.received_elements_in_this_cycle_count += 1

        # set initial value for min/max id in current process cycle
        if self.received_elements_in_this_cycle_count == 1:
            self.current_min_user_id = parsed_wiki_history['user_id']
            self.current_max_user_id = parsed_wiki_history['user_id'] + 1

        self.current_min_user_id = min(self.current_min_user_id,
                                       parsed_wiki_history['user_id'])
        # self.current_max_user_id is the upper-bound that should be included, +1 so it won't be skipped
        self.current_max_user_id = max(self.current_max_user_id,
                                       parsed_wiki_history['user_id'] + 1)

        if self.received_elements_in_this_cycle_count >= self.commit_threshold:
            self.write_to_db()

        return item

    def write_to_db(self):
        """
        Diff record in webpage and db and update/create/skip records
        :return:
        """
        # reset the counter
        self.received_elements_in_this_cycle_count = 0
        skipped_entities_count = 0
        items_to_process = self.items_to_process
        entities_to_create = self.entities_to_create
        entities_to_update = self.entities_to_update
        self.items_to_process = []
        self.entities_to_create = []
        self.entities_to_update = []

        database_response_entities = self.wikiHistoryTableDatabaseExecutor.query_user_range(
            self.current_min_user_id,
            self.current_max_user_id)

        database_response_dict = {}

        for db_entity in database_response_entities:
            database_response_dict[
                (db_entity.user_id,
                 db_entity.entry_id,
                 db_entity.edit_type,
                 None if db_entity.edit_time is None else db_entity.edit_time.timestamp())] = db_entity

        for wiki_history in items_to_process:
            primary_key_from_scrapy_item = (
                wiki_history['user_id'],
                wiki_history['entry_id'],
                wiki_history['edit_type'],
                None if wiki_history['edit_time'] is None else wiki_history[
                    'edit_time'].timestamp()
            )

            entity_in_db = database_response_dict.get(
                primary_key_from_scrapy_item)
            if entity_in_db:
                # we assume wiki edit history to be immutable, so skipping it
                skipped_entities_count += 1
            else:
                # entity has been parsed in self.process_item()
                # doesn't need to be parsed again
                entity = WikiHistory(wiki_history, False)
                entities_to_create.append(entity)

        start_id = self.current_min_user_id
        end_id = self.current_max_user_id
        logger.info('Creating %s new instances in user_id range (%s, %s)',
                    len(entities_to_create), start_id,
                    end_id)
        created_entities = self.wikiHistoryTableDatabaseExecutor.create(
            entities_to_create)
        self.stats['created_entities'] += created_entities

        self.stats['skipped_entities'] += skipped_entities_count
        logger.info(
            'Skipping %s existed instances in range (%s, %s) as there\'s no difference',
            skipped_entities_count,
            start_id, end_id)
        logger.info('Updating %s existed instances in range (%s, %s)',
                    len(entities_to_update), start_id, end_id)
        updated_entities = self.wikiHistoryTableDatabaseExecutor.update(
            entities_to_update)
        self.stats['updated_entities'] += updated_entities


class DBPipeline(object):
    """
    Pipeline to write to database
    Probably instead of writing messy code to handle diff, a better way is to write all results into a staging table,
    then dropping current table and renaming the staging table to 'record'
    Currently this pipeline works like:
    1. Receiving item from self.process_item
    2. For every self.commit_threshold iteams, processing them and writing to database
    3. Record a set of entities that's going to be deleted, update the set every processing batch (thus
    self.entities_seen is going to be a HUGE set, again, probably...)
    4. Deleting entities once we reach self.close_spider()
    """

    def __init__(self):
        self.commit_threshold = 1000
        # threshold to abort deleting command: typically 1000k records are not likely getting deleted at the same time
        self.abort_deleting_threshold = 1000000
        self.optimize_items_seen_dict_threshold = 100000  # optimize_items_seen_dict once 100k records are received
        self.recordTableDatabaseExecutor = RecordTableDatabaseExecutor(Record,
                                                                       self.commit_threshold)
        # a process cycle = process elements until we receive self.commit_threshold number of elements
        self.received_elements_in_this_cycle_count = 0  # items received in this process cycle
        self.received_elements_total_count = 0  # items received so far
        self.current_min_user_id = 1  # current min user id in this process cycle
        self.current_max_user_id = 2  # current max user id in this process cycle
        self.items_to_process = []
        self.entities_to_create = []
        self.entities_to_update = []
        self.entities_seen = {}  # a nested dict, user_id is the dict ket, each value contains set of subject_id
        self.entities_might_need_deleting = set()  # contains the primary key, tuple of entities, tuple(subject_id,
        # user_id)
        #  please refer to scrapy's log for http response summary for failed_to_update entities
        self.stats = {
            'created_entities': 0,
            'updated_entities': 0,
            'skipped_entities': 0,
            'deleted_entities': 0,
        }

    def close_spider(self, spider):
        if spider.name != 'record':
            return

        # process items that're left(in the last cycle, element won't be )
        self.write_to_db()
        # free memory
        self.entities_seen = {}
        if len(
            self.entities_might_need_deleting) >= self.abort_deleting_threshold:
            logger.error(
                '%s number of records are getting deleted from the database, which is not likely to '
                'happen! Deleting won\'t be performed')
        else:
            logger.info(
                'Scraping completes, starting deleting entities that are not on web but in db now.')
            logger.info('Deleting %s existed instances',
                        len(self.entities_might_need_deleting))
            deleted_entities = self.recordTableDatabaseExecutor.delete(
                self.entities_might_need_deleting)
            self.stats['deleted_entities'] += deleted_entities
        logger.info('Finished scraping, affected rows stats: %s', self.stats)
        logger.info(
            'Note: the stats might not reflect the final database state, i.e. if db is manipulated by another session '
            'at the same time.')
        self.recordTableDatabaseExecutor.close_session()

    def process_item(self, item, spider):
        if spider.name != 'record':
            return item

        self.received_elements_in_this_cycle_count += 1
        self.received_elements_total_count += 1
        parsed_record = Record.parse_input(item)

        # set initial value for min/max id in current process cycle
        if self.received_elements_in_this_cycle_count == 1:
            self.current_min_user_id = parsed_record['user_id']
            self.current_max_user_id = parsed_record['user_id'] + 1

        self.current_min_user_id = min(self.current_min_user_id,
                                       parsed_record['user_id'])
        # self.current_max_user_id is the upper-bound that should be included, +1 so it won't be skipped
        self.current_max_user_id = max(self.current_max_user_id,
                                       parsed_record['user_id'] + 1)
        current_user_id = parsed_record['user_id']
        if current_user_id not in self.entities_seen:
            self.entities_seen[current_user_id] = set()

            self.items_to_process.append(parsed_record)
        else:
            # only if current record is not seen under the user record set before, append it to the process queue
            # this is needed to handle situations such as duplicated record
            # i.e. user A marked subject a as status 1 before, then during the scraping, user marks a as status 2
            # then two status of same subject might be received
            if parsed_record['subject_id'] not in self.entities_seen[
                current_user_id]:
                self.items_to_process.append(parsed_record)

        self.entities_seen[parsed_record['user_id']].add(
            parsed_record['subject_id'])

        if self.received_elements_in_this_cycle_count >= self.commit_threshold:
            self.write_to_db()

        if self.received_elements_total_count % self.optimize_items_seen_dict_threshold == 0:
            self.optimize_items_seen_dict(self.current_min_user_id)

        return item

    def optimize_items_seen_dict(self, current_min_user_id):
        """
        We don't really want to keep a dict which contains all records from all users
        (bangumi at least has ~6000k records back to 2017!) at the end.
        Especially, if all records from one user has been processed, all related records for that user can be deleted
        However, the tricky part is: there's no way to check whether all records from one user has been processed or not
        that being said, current_min_user_id MIGHT be unreliable
        Scrapy might return user record out of order, i.e. first record from user#2, first record from user#2...
        We don't know what's the last record for user #1(== all records from this user can be cleared)
        Fortunately, the order is 'eventually sequential', that being said, user #2 might come before user #1
        but user #10000 generally won't come before user #1, so we remove all records for uid < (current_min_user_id
        - 10000)
        from the dict
        :param current_min_user_id:
        :return:
        """
        looking_back_threshold = 10000
        removed_users = 0
        logger.info('Starting optimizing entities_seen to freeze memory now.')
        for user_id in sorted(self.entities_seen.keys()):
            if user_id < max(current_min_user_id - looking_back_threshold, 1):
                try:
                    del self.entities_seen[user_id]
                    removed_users += 1
                except KeyError:
                    # in case user_id is not in self.entities_seen
                    # however it's unlikely to happen so we log this exception to check what happened
                    # "A try/except block is extremely efficient if no exceptions are raised."
                    logger.warning(
                        'Trying to delete %s from entities_seen but it\'s not there.',
                        user_id)
                    pass
            else:
                break
        logger.info('Deleted %s users from self.items_seen', removed_users)
        logger.info(
            'Number of instances that might need deleting after optimizing: %s',
            len(self.entities_might_need_deleting))

    def write_to_db(self):
        """
        Diff record in webpage and db and update/create/skip records
        :return:
        """
        # reset the counter
        self.received_elements_in_this_cycle_count = 0  # items received in this process cycle

        skipped_entities_count = 0
        items_to_process = self.items_to_process
        entities_to_create = self.entities_to_create
        entities_to_update = self.entities_to_update
        self.items_to_process = []
        self.entities_to_create = []
        self.entities_to_update = []

        database_response_entities = self.recordTableDatabaseExecutor.query_range(
            self.current_min_user_id,
            self.current_max_user_id)

        database_response_dict = {}

        new_entities_might_need_deleting = set()

        for db_entity in database_response_entities:
            database_response_dict[
                (db_entity.user_id, db_entity.subject_id)] = db_entity
            if self.entities_seen.get(
                db_entity.user_id) is None or db_entity.subject_id not in \
                self.entities_seen.get(db_entity.user_id):
                new_entities_might_need_deleting.add(
                    (db_entity.user_id, db_entity.subject_id))

        # first we assume all records from db need to be deleted

        self.entities_might_need_deleting.update(
            new_entities_might_need_deleting)

        for record in items_to_process:
            primary_key_from_scrapy_item = (
                record['user_id'], record['subject_id'])

            entity_in_db = database_response_dict.get(
                primary_key_from_scrapy_item)
            if entity_in_db:
                # if the record is in scrapy's response, which indicates it's still on web page, remove it from the set
                try:
                    self.entities_might_need_deleting.remove(
                        primary_key_from_scrapy_item)
                except KeyError:
                    # entity might not exist in deleting set, in such case just ignore the error
                    pass
                difference = entity_in_db.diff_self_with_input(record)
                if len(list(difference)) > 0:
                    # db/API contain entity and it has difference, overwriting data in db
                    entity_in_db.set_attribute(record)
                    entities_to_update.append(entity_in_db)
                else:
                    # db/API contain entity but nothing changes, skipping it
                    skipped_entities_count += 1
            else:
                # record has been parsed in self.process_item(), doesn't need to be parsed again
                entity = Record(record, False)
                entities_to_create.append(entity)

        start_id = self.current_min_user_id
        end_id = self.current_max_user_id
        logger.info('Creating %s new instances in user_id range (%s, %s)',
                    len(entities_to_create), start_id,
                    end_id)
        created_entities = self.recordTableDatabaseExecutor.create(
            entities_to_create)
        self.stats['created_entities'] += created_entities

        self.stats['skipped_entities'] += skipped_entities_count
        logger.info(
            'Skipping %s existed instances in range (%s, %s) as there\'s no difference',
            skipped_entities_count,
            start_id, end_id)

        logger.info('Updating %s existed instances in range (%s, %s)',
                    len(entities_to_update), start_id, end_id)
        updated_entities = self.recordTableDatabaseExecutor.update(
            entities_to_update)
        self.stats['updated_entities'] += updated_entities
