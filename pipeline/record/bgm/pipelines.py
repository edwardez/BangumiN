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
from models.Record import Record

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
        file = open(spider.name + '-' + datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S") + '.tsv*',
                    'wb')
        self.files[spider] = file

        self.exporter = CsvItemExporter(file, include_headers_line=True, join_multivalued=';', encoding="utf-8",
                                        delimiter='\t')
        if spider.name == 'user':
            self.exporter.fields_to_export = ['uid', 'name', 'nickname', 'joindate', 'activedate']
        elif spider.name == 'subject':
            self.exporter.fields_to_export = ['subjectid', 'order', 'subjectname', 'subjecttype', 'rank', 'date',
                                              'votenum', 'favnum', 'staff', 'relations']
        elif spider.name == 'record':
            self.exporter.fields_to_export = ['uid', 'name', 'nickname', 'iid', 'typ', 'state', 'adddate', 'rate',
                                              'tags', 'comment']
        elif spider.name == 'index':
            self.exporter.fields_to_export = ['indexid', 'creator', 'favourite', 'date', 'items']
        elif spider.name == 'friends':
            self.exporter.fields_to_export = ['user', 'friend']
        self.exporter.start_exporting()

    def spider_closed(self, spider):
        self.exporter.finish_exporting()
        file = self.files.pop(spider)
        filename = file.name
        newname = filename[:-5] + '-' + datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S") + '.tsv'
        file.close()
        os.rename(filename, newname)

    def process_item(self, item, spider):
        self.exporter.export_item(item)
        return item


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
        self.recordTableDatabaseExecutor = RecordTableDatabaseExecutor(Record, self.commit_threshold)
        # a process cycle = process elements until we receive self.commit_threshold number of elements
        self.received_elements_count = 0  # items received in this process cycle
        self.current_min_user_id = 1  # current min user id in this process cycle
        self.current_max_user_id = 2  # current max user id in this process cycle
        self.items_to_process = []
        self.entities_to_create = []
        self.entities_to_update = []
        self.entities_seen = set()  # contains the primary key, tuple of entities, tuple(subject_id, user_id)
        self.entities_to_delete = set()  # contains the primary key, tuple of entities, tuple(subject_id, user_id)
        self.entities_to_skip = set()  # contains the primary key, tuple of entities, tuple(subject_id, user_id)
        #  please refer to scrapy's log for http response summary for failed_to_update entities
        self.stats = {
            'created_entities': 0,
            'updated_entities': 0,
            'skipped_entities': 0,
            'deleted_entities': 0,
        }

    def close_spider(self, spider):

        # process items that're left(in the last cycle, element won't be )
        self.write_to_db()
        # free memory
        self.entities_seen = set()  # contains the primary key, tuple of entities, tuple(subject_id, user_id)
        if len(self.entities_to_delete) >= self.abort_deleting_threshold:
            logger.error('%s number of records are getting deleted from the database, which is not likely to '
                         'happen! Deleting won\'t be performed')
        else:
            logger.info('Scraping completes, starting deleting entities that are not on web but in db now.')
            logger.info('Deleting %s existed instances', len(self.entities_to_delete))
            deleted_entities = self.recordTableDatabaseExecutor.delete(self.entities_to_delete)
            self.stats['deleted_entities'] += deleted_entities
        logger.info('Finished scraping, affected rows stats: %s', self.stats)
        logger.info(
            'Note: the stats might not reflect the final database state, i.e. if db is manipulated by another session '
            'at the same time.')
        self.recordTableDatabaseExecutor.close_session()

    def process_item(self, item, spider):
        self.received_elements_count += 1
        parsed_record = Record.parse_input(item)

        # set initial value for min/max id in current process cycle
        if self.received_elements_count == 1:
            self.current_min_user_id = parsed_record['user_id']
            self.current_max_user_id = parsed_record['user_id'] + 1

        primary_key_from_scrapy_item = (parsed_record['subject_id'], parsed_record['user_id'])
        self.current_min_user_id = min(self.current_min_user_id, parsed_record['user_id'])
        # self.current_max_user_id is the upper-bound that should be included, +1 so it won't be skipped
        self.current_max_user_id = max(self.current_max_user_id, parsed_record['user_id'] + 1)
        if primary_key_from_scrapy_item not in self.entities_seen:
            self.entities_seen.add(primary_key_from_scrapy_item)
            self.items_to_process.append(parsed_record)

        if self.received_elements_count >= self.commit_threshold:
            # reset the counter
            self.received_elements_count = 0  # items received in this process cycle
            self.write_to_db()

        # logger.info('current self.received_elements_count %s', self.received_elements_count)

        return item

    def write_to_db(self):
        database_response_entities = self.recordTableDatabaseExecutor.query_range(self.current_min_user_id,
                                                                                  self.current_max_user_id)

        database_response_dict = {}
        for db_entity in database_response_entities:
            database_response_dict[(db_entity.subject_id, db_entity.user_id)] = db_entity

        # first we assume all records from db need to be deleted
        # complexity is O(len(database_response_dict.keys())) every time
        entities_might_need_deleting = set(database_response_dict.keys()) - self.entities_seen

        for record in self.items_to_process:
            primary_key_from_scrapy_item = (record['subject_id'], record['user_id'])

            if database_response_dict.get(primary_key_from_scrapy_item):

                # if the record is in scrapy's response, which indicates it's still on web page, remove it from the set
                if primary_key_from_scrapy_item in entities_might_need_deleting:
                    entities_might_need_deleting.remove(primary_key_from_scrapy_item)
                if primary_key_from_scrapy_item in self.entities_to_delete:
                    self.entities_to_delete.remove(primary_key_from_scrapy_item)
                entity_in_db = database_response_dict.get(primary_key_from_scrapy_item)
                difference = entity_in_db.diff_self_with_input(record)
                if len(list(difference)) > 0:
                    # db/API contain entity and it has difference, overwriting data in db
                    entity_in_db.set_attribute(record)
                    self.entities_to_update.append(entity_in_db)
                else:
                    # db/API contain entity but nothing changes, skipping it
                    self.entities_to_skip.add((entity_in_db.subject_id, entity_in_db.user_id))
            else:
                # record has been parsed in self.process_item(), doesn't need to be parsed again
                entity = Record(record, False)
                self.entities_to_create.append(entity)

        start_id = self.current_min_user_id
        end_id = self.current_max_user_id
        logger.info('Creating %s new instances in user_id range (%s, %s)', len(self.entities_to_create), start_id,
                    end_id)
        created_entities = self.recordTableDatabaseExecutor.create(self.entities_to_create)
        self.stats['created_entities'] += created_entities

        skipped_entities = len(self.entities_to_skip)
        self.stats['skipped_entities'] += skipped_entities
        logger.info('Skipping %s existed instances in range (%s, %s) as there\'s no difference',
                    len(self.entities_to_skip),
                    start_id, end_id)

        logger.info('Updating %s existed instances in range (%s, %s)', len(self.entities_to_update), start_id, end_id)
        updated_entities = self.recordTableDatabaseExecutor.update(self.entities_to_update)
        self.stats['updated_entities'] += updated_entities

        # update the global entity deleting set
        self.entities_to_delete.update(entities_might_need_deleting)
        # finally, reset relevant variables in this process cycle
        self.items_to_process = []
        self.entities_to_create = []
        self.entities_to_update = []
        self.entities_to_skip = set()
