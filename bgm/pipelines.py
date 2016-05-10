# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
from scrapy import log
from scrapy.exceptions import DropItem
from twisted.enterprise import adbapi
from scrapy import signals
from scrapy.contrib.exporter import JsonLinesItemExporter
import cPickle
import codecs
import datetime


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


class JsonPipeline(object):
    """Index should be recorded in a json file."""
    def __init__(self):
        self.files = {}

    @classmethod
    def from_crawler(cls, crawler):
         pipeline = cls()
         crawler.signals.connect(pipeline.spider_opened, signals.spider_opened)
         crawler.signals.connect(pipeline.spider_closed, signals.spider_closed)
         return pipeline

    def spider_opened(self, spider):
        if spider.name=='friends' or spider.name=='index' or \
           spider.name=='record' or spider.name=='subject':
            file = open('%s.json' % spider.name, 'wb')
            self.files[spider] = file
            self.exporter = JsonLinesItemExporter(file)
            if spider.name=='record':
                self.exporter.fields_to_export = ['name','iid','tags']
            elif spider.name=='subject':
                self.exporter.fields_to_export = ['subjectid','staff',
                'relations','tags']
            self.exporter.start_exporting()

    def spider_closed(self, spider):
        if spider.name=='friends' or spider.name=='index' \
           or spider.name=='record' or spider.name=='subject':
            self.exporter.finish_exporting()
            file = self.files.pop(spider)
            file.close()

    def process_item(self, item, spider):
        if spider.name=='friends' or spider.name=='index' or \
        spider.name=='record' or spider.name=='subject':
            self.exporter.export_item(item)
        return item


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
                cPickle.dump(self.subjectinfo, fw)
                cPickle.dump(self.relations, fw)

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
