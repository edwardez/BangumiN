# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
from scrapy import log
from scrapy.exceptions import DropItem
from twisted.enterprise import adbapi
from scrapy import signals
from scrapy.exporters import JsonLinesItemExporter, CsvItemExporter
import pickle
import codecs
import datetime
import os
from .settings import *
if UPLOAD_TO_AZURE_STORAGE:
    from azure.storage.blob import BlockBlobService, ContentSettings



class MySQLPipeline(object):
    def __init__(self, dbpool):
        self.dbpool = dbpool

    @classmethod
    def from_settings(cls, settings):
        dbargs = dict(
            host=settings['MYSQL_HOST'],
            db=settings['MYSQL_DBNAME'],
            user=settings['MYSQL_USER'],
            passwd=settings['MYSQL_PASSWD'],
            charset='utf8',
            use_unicode=True,
        )
        dbpool = adbapi.ConnectionPool('MySQLdb', **dbargs) # dbpool is a pool
        return cls(dbpool)# cls is the name of the class

    def process_item(self, item, spider):
        if spider.name=='user' or spider.name=='record' or \
        spider.name=='subject':
            # run db query in the thread pool
            d = self.dbpool.runInteraction(self._do_upsert, item, spider)# a derefer
            d.addErrback(self._handle_error, item, spider)
            # at the end return the item in case of success or failure
            d.addBoth(lambda _: item)
            # return the deferred instead the item. This makes the engine to
            # process next item (according to CONCURRENT_ITEMS setting) after this
            # operation (deferred) has finished.
            return d
        else:
            return item

    def _do_upsert(self, conn, item, spider):
        """Perform an insert or update."""
        if item.__class__.__name__=='User':
            conn.execute("""
            insert into users (uid, name, joindate)
            values (%s, %s, %s)
            """, (item["uid"], item["name"], item["date"].isoformat()))

        # spider.log("Item stored in db: %s\n" % (item["name"]))

        elif item.__class__.__name__=='Record':

            conn.execute("insert into record (name, typ, iid, state, adddate, \
            rate) values (\"%s\", \"%s\", %s, \"%s\", \"%s\", \
            %s)"%(item["name"], item["typ"], str(item["iid"]),\
            item["state"], item["date"].isoformat(), self._getrate(item)))

        elif item.__class__.__name__=='Subject':
            conn.execute("insert into subject (id, name, type, redid, \
            date, rank, votenum, favnum) values (\"%s\", \"%s\", \"%s\",\
            %s, \"%s\", %s, \"%s\", \"%s\")"%(item['subjectid'],
            item['subjectname'], item['subjecttype'], self._getauthenticid(item),
            self._getdate(item), self._getrank(item),
            str(item['votenum']), str(sum(item['favcount'])) ))

    def _handle_error(self, failure, item, spider):
        """Handle occurred on db interaction."""
        # do nothing, just log
        log.err(failure)

    def _gettags(self,item):
        if not "tags" in item:
            return "NULL"
        else:
            return '\"'+u" ".join(item["tags"])+'\"'

    def _getrate(self, item):
        if not "rate" in item:
            return "NULL"
        else:
            return str(item["rate"])

    def _getrank(self, item):
        if item["rank"] is None:
            return "NULL"
        else:
            return str(item["rank"])

    def _getdate(self, item):
        if item["date"] is None:
            return "NULL"
        else:
            return item["date"].date().isoformat()

    def _getcomment(self, item):
        if not "comment" in item:
            return "NULL"
        else:
            return '\"'+item["comment"]+'\"'

    def _getauthenticid(self, item):
        if item['authenticid'] is None:
            return "NULL"
        else:
            return str(item['authenticid'])

class UserPipeline(object):
    def __init__(self, dbpool):
        self.dbpool = dbpool
        self.files = {}
        self.deltauser = []

    @classmethod
    def from_crawler(cls, crawler):
        dbargs = dict(
            host=crawler.settings.get('MYSQL_HOST'),
            db=crawler.settings.get('MYSQL_DBNAME'),
            user=crawler.settings.get('MYSQL_USER'),
            passwd=crawler.settings.get('MYSQL_PASSWD'),
            charset='utf8',
            use_unicode=True,
            unix_socket=crawler.settings.get("MYSQL_SOCKET")
        )
        dbpool = adbapi.ConnectionPool('MySQLdb', **dbargs) # dbpool is a pool
        pipeline = cls(dbpool)
        crawler.signals.connect(pipeline.spider_opened, signals.spider_opened)
        crawler.signals.connect(pipeline.spider_closed, signals.spider_closed)
        return pipeline

    def process_item(self, item, spider):
        if spider.name=='user':
            # run db query in the thread pool
            d = self.dbpool.runInteraction(self._do_upsert, item, spider)# a derefer
            d.addErrback(self._handle_error, item, spider)
            # at the end return the item in case of success or failure
            d.addBoth(lambda _: item)
            # return the deferred instead the item. This makes the engine to
            # process next item (according to CONCURRENT_ITEMS setting) after this
            # operation (deferred) has finished.
            return d
        else:
            return item

    def spider_opened(self, spider):
        if spider.name=='user':
            file = codecs.open('user.json', 'wb', encoding="utf-8")
            self.files[spider] = file
            self.exporter = JsonLinesItemExporter(file, encoding="utf-8")
            self.exporter.start_exporting()

    def spider_closed(self, spider):
        if spider.name=='user':
            self.exporter.finish_exporting()
            file = self.files.pop(spider)
            file.close()
            if self.deltauser:
                with open("deltauser-"+datetime.date.today().isoformat()+".tsv", 'w') as fw:
                    for n in self.deltauser:
                        fw.write("%s\n"%(n,))

    def _do_upsert(self, conn, item, spider):
        """
        This function performs a check of whether user is recorded in the db
        If yes, update the last_active and nickname if necessary.
        If no, record this in the delta file in json.
        """
        conn.execute("""
        select * from users where name=%s
        """, (item["name"],))
        rtn = conn.fetchone()

        if rtn:
            if rtn[1]!=item['nickname'] or rtn[4]!=item['activedate']:
                conn.execute("""
                update users set nickname=%s, activedate=%s where name=%s
                """, (self._str_null_processor(item['nickname']),
                item['activedate'].isoformat(),
                item['name']))
                self.deltauser.append(item['name'])
        else:
            self.exporter.export_item(item)
            self.deltauser.append(item['name'])


    def _handle_error(self, failure, item, spider):
        """Handle occurred on db interaction."""
        # do nothing, just log
        log.err(failure)

    def _str_null_processor(self, s):
        if not s:
            return "NULL"
        else:
            return s

class RecordPipeline(object):
    def __init__(self, dbpool):
        self.dbpool = dbpool
        self.files = {}
        self.deltaitems = set()

    @classmethod
    def from_crawler(cls, crawler):
        dbargs = dict(
            host=crawler.settings.get('MYSQL_HOST'),
            db=crawler.settings.get('MYSQL_DBNAME'),
            user=crawler.settings.get('MYSQL_USER'),
            passwd=crawler.settings.get('MYSQL_PASSWD'),
            charset='utf8',
            use_unicode=True,
            unix_socket=crawler.settings.get("MYSQL_SOCKET")
        )
        dbpool = adbapi.ConnectionPool('MySQLdb', **dbargs) # dbpool is a pool
        pipeline = cls(dbpool)
        crawler.signals.connect(pipeline.spider_opened, signals.spider_opened)
        crawler.signals.connect(pipeline.spider_closed, signals.spider_closed)
        return pipeline

    def process_item(self, item, spider):
        if spider.name=='record':
            d = self.dbpool.runInteraction(self._do_upsert, item, spider)
            d.addErrback(self._handle_error, item, spider)
            d.addBoth(lambda _: item)
            return d
        else:
            return item

    def spider_opened(self, spider):
        if spider.name=='record':
            file = codecs.open('record.json', 'wb', encoding="utf-8")
            self.files[spider] = file
            self.exporter = JsonLinesItemExporter(file, encoding="utf-8")
            self.exporter.start_exporting()

    def spider_closed(self, spider):
        if spider.name=='record':
            self.exporter.finish_exporting()
            file = self.files.pop(spider)
            file.close()
            deltaitems = list(self.deltaitems)
            if deltaitems:
                with open("deltaitem-"+datetime.date.today().isoformat()+".tsv", 'w') as fw:
                    for n in deltaitems:
                        fw.write("%s\n"%(n,))

    def _do_upsert(self, conn, item, spider):
        """
        This function performs a check of whether user is recorded in the db
        If yes, update the last_active and nickname if necessary.
        If no, record this in the delta file in json.
        """
        conn.execute("""
        select * from record where name=%s and iid=%s
        """, (item['name'],item['iid']))
        rtn = conn.fetchone()

        if rtn:
            if rtn[4]!=item['adddate']:
                conn.execute("""
                update record set state=%s, adddate=%s, rate=%s, tags=%s
                where name=%s and iid=%s
                """, (item['state'],
                item['adddate'].isoformat(),
                self._digit_null_processor(item['rate']),
                self._str_null_processor(item['tags']),
                item['name'],
                item['iid']))
                self.deltaitems.add(item['iid'])
        else:
            self.exporter.export_item(item)
            self.deltaitems.add(item['iid'])


    def _handle_error(self, failure, item, spider):
        """Handle occurred on db interaction."""
        # do nothing, just log
        log.err(failure)

    def _str_null_processor(self, s):
        if not s:
            return "NULL"
        else:
            return s

    def _digit_null_processor(self, num):
        if not num:
            return "NULL"
        else:
            return str(num)


class SubjectPipeline(object):
    def __init__(self, dbpool):
        self.dbpool = dbpool
        self.files = {}

    @classmethod
    def from_crawler(cls, crawler):
        dbargs = dict(
            host=crawler.settings.get('MYSQL_HOST'),
            db=crawler.settings.get('MYSQL_DBNAME'),
            user=crawler.settings.get('MYSQL_USER'),
            passwd=crawler.settings.get('MYSQL_PASSWD'),
            charset='utf8',
            use_unicode=True,
            unix_socket=crawler.settings.get("MYSQL_SOCKET")
        )
        dbpool = adbapi.ConnectionPool('MySQLdb', **dbargs) # dbpool is a pool
        pipeline = cls(dbpool)
        crawler.signals.connect(pipeline.spider_opened, signals.spider_opened)
        crawler.signals.connect(pipeline.spider_closed, signals.spider_closed)
        return pipeline

    def process_item(self, item, spider):
        if spider.name=='subject':
            d = self.dbpool.runInteraction(self._do_upsert, item, spider)
            d.addErrback(self._handle_error, item, spider)
            d.addBoth(lambda _: item)
            return d
        else:
            return item

    def spider_opened(self, spider):
        if spider.name=='subject':
            file = codecs.open('subject.json', 'wb', encoding="utf-8")
            self.files[spider] = file
            self.exporter = JsonLinesItemExporter(file, encoding="utf-8")
            self.exporter.fields_to_export = ['subjectid', 'subjecttype',
            'subjectname', 'authenticid', 'rank', 'votenum', 'favnum', 'date']
            self.exporter.start_exporting()

    def spider_closed(self, spider):
        if spider.name=='subject':
            self.exporter.finish_exporting()
            file = self.files.pop(spider)
            file.close()

    def _do_upsert(self, conn, item, spider):
        """
        This function performs a check of whether user is recorded in the db
        If yes, update the last_active and nickname if necessary.
        If no, record this in the delta file in json.
        """
        conn.execute("""
        select * from subject where id=%s
        """, (item['authenticid'],))
        rtn = conn.fetchone()

        if rtn:
            conn.execute("""
            update subject
            set trueid=%s, name=%s, type=%s, date=%s, rank=%s, favnum=%s, votenum=%s
            where id=%s
            """, (item['subjectid'],
            self._str_null_processor(item['subjectname']),
            item['subjecttype'],
            self._date_null_processor(item['date']),
            self._digit_null_processor(item['rank']),
            sum(item['favnum']),
            item['votenum'],
            item['authenticid']))
        else:
            self.exporter.export_item(item)


    def _handle_error(self, failure, item, spider):
        """Handle occurred on db interaction."""
        # do nothing, just log
        log.err(failure)

    def _str_null_processor(self, s):
        if not s:
            return "NULL"
        else:
            return s

    def _digit_null_processor(self, num):
        if not num:
            return "NULL"
        else:
            return str(num)

    def _date_null_processor(self, dt):
        if not dt:
            return None
        else:
            return dt.isoformat()


class SubjectInfoPipeline(object):
    """We do the statistical staff here."""
    def __init__(self):
        self.subjectinfo = {"Anime":{}, "Book":{}, "Music":{}, "Game":{},
                            "Real":{}};
        self.relations = {};

    @classmethod
    def from_crawler(cls, crawler):
         pipeline = cls()
         crawler.signals.connect(pipeline.spider_closed, signals.spider_closed)
         return pipeline

    def spider_closed(self, spider):
        if spider.name=='subjectinfo':
            with open("subjectinfo.pkl", "wb") as fw:
                pickle.dump(self.subjectinfo, fw)
                pickle.dump(self.relations, fw)

    def process_item(self, item, spider):
        if spider.name=='subjectinfo':
            tp = item['subjecttype']
            for staff in item['infobox']:
                if staff in self.subjectinfo[tp].keys():
                    self.subjectinfo[tp][staff]+=1
                else:
                    self.subjectinfo[tp][staff]=1
            for rela in item['relations']:
                if rela in self.relations.keys():
                    self.relations[rela]+=1
                else:
                    self.relations[rela]=1
        return item

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
        file = open(spider.name+'-'+datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S")+'.tsv*', 
                           'wb')
        self.files[spider] = file

        self.exporter = CsvItemExporter(file, include_headers_line=True, join_multivalued=';', encoding="utf-8", delimiter='\t')
        if spider.name=='user':
            self.exporter.fields_to_export = ['uid', 'name', 'nickname', 'joindate', 'activedate']
        elif spider.name=='subject':
            self.exporter.fields_to_export = ['subjectid', 'order', 'subjectname', 'subjecttype', 'rank', 'date', 'votenum', 'favnum', 'relations']
        elif spider.name=='record':
            self.exporter.fields_to_export = ['name', 'uid', 'iid', 'typ', 'state', 'adddate', 'rate', 'tags', 'comment']
        elif spider.name=='index':
            self.exporter.fields_to_export = ['indexid', 'creator', 'favourite', 'date', 'items']
        elif spider.name=='friends':
            self.exporter.fields_to_export = ['user', 'friend']
        self.exporter.start_exporting()

    def spider_closed(self, spider):
        self.exporter.finish_exporting()
        file = self.files.pop(spider)
        filename = file.name
        newname = filename[:-5]+'-'+datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S")+'.tsv'
        file.close()
        os.rename(filename, newname)
        if UPLOAD_TO_AZURE_STORAGE:
            block_blob_service = BlockBlobService(account_name=AZURE_ACCOUNT_NAME, account_key=AZURE_ACCOUNT_KEY)
            block_blob_service.create_blob_from_path(AZURE_CONTAINER,
                                                    newname,
                                                    newname,
                                                    content_settings=ContentSettings(content_type='text/tab-separated-values')
                                                            )
                                                            

    def process_item(self, item, spider):
        self.exporter.export_item(item)
        return item