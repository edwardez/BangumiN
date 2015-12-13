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
        if spider.name=='user' or spider.name=='record':
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
            if not item['prohibited']:
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

    def _getcomment(self, item):
        if not "comment" in item:
            return "NULL"
        else:
            return '\"'+item["comment"]+'\"'


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
        if spider.name=='friends' or spider.name=='index' or spider.name=='record':
            file = open('%s.json' % spider.name, 'wb')
            self.files[spider] = file
            self.exporter = JsonLinesItemExporter(file)
            if spider.name=='record':
                self.exporter.fields_to_export = ['name','iid','tags']
            self.exporter.start_exporting()

    def spider_closed(self, spider):
        if spider.name=='friends' or spider.name=='index' or spider.name=='record':
            self.exporter.finish_exporting()
            file = self.files.pop(spider)
            file.close()

    def process_item(self, item, spider):
        if spider.name=='friends' or spider.name=='index' or spider.name=='record':
            self.exporter.export_item(item)
        return item


class SubjectInfoPipeline(object):
    """We do the statistical staff here."""
    def __init__(self):
        self.subjectinfo = {"Anime":{}, "Book":{}, "Music":{}, "Game":{}, "Real":{}};
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
