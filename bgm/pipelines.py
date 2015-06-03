# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
from scrapy import log
from scrapy.exceptions import DropItem
from twisted.enterprise import adbapi
import json

class RecordPipeline(object):
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
        # run db query in the thread pool
        d = self.dbpool.runInteraction(self._do_upsert, item, spider)# a derefer
        d.addErrback(self._handle_error, item, spider)
        # at the end return the item in case of success or failure
        d.addBoth(lambda _: item)
        # return the deferred instead the item. This makes the engine to
        # process next item (according to CONCURRENT_ITEMS setting) after this
        # operation (deferred) has finished.
        return d

    def _do_upsert(self, conn, item, spider):
        """Perform an insert or update."""
        #if item.__class__.__name__=='BgmUser':
        #    conn.execute("""
        #    insert into users (uid, name, joindate)
        #    values (%s, %s, %s)
        #    """, (item["uid"], item["name"], item["joindate"].isoformat()))

        #    spider.log("Item stored in db: %s\n" % (item["name"]))

        #elif item.__class__.__name__=='WatchRecord':

            conn.execute("insert into record (name, typ, iid, state, adddate, rate, comment, tags) values (\"%s\", \"%s\", %s, \"%s\", \"%s\", %s, %s, %s)" \
            %(item["name"], item["typ"], str(item["iid"]), item["state"], item["date"].isoformat(), self._getrate(item), self._getcomment(item), self._gettags(item)))

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

class IndexPipeline(object):
    """Index should be recorded in a json file."""
    def __init__(self):
        self.file = open('items.jl', 'wb')

    def process_item(self, item, spider):
        line = json.dumps(dict(item)) + "\n"
        self.file.write(line)
        return item
