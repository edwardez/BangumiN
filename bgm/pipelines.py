# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
from scrapy import log
from scrapy.exceptions import DropItem
from twisted.enterprise import adbapi

class BgmPipeline(object):
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
        if item.__class__.__name__=='BgmUser':
            conn.execute("""select exists(
            select 1 from users where name = %s
            )""", (item["name"]))
            ret = conn.fetchone()[0]

            if not ret:
                conn.execute("""
                insert into users (uid, name, joindate)
                values (%s, %s, %s)
                """, (str(item["uid"]), item["name"], item["joindate"].isoformat()))

            spider.log("Item stored in db: %s\n" % (item["name"]))

        elif item.__class__.__name__=='WatchRecord':
            conn.execute("""select exists(
            select 1 from record where name = %s and typ = %s and iid = %s
            )""", (item["name"], item["typ"], str(item["iid"])))
            ret = conn.fetchone()[0]

            if not ret:
                conn.execute("""
                insert into record (name, typ, iid, state, adddate)
                values (%s, %s, %s, %s, %s)
                """, (item["name"], item["typ"], str(item["iid"]), item["state"], item["date"].isoformat()))
            else:
                conn.execute("""
                update record
                set state = %s, adddate = %s
                where name = %s and typ = %s and iid = %s
                """, (item["state"], item["date"].isoformat(), item["name"], item["typ"], str(item["iid"])))

            if "rate" in item:
                conn.execute("""
                update record
                set rate = %s
                where name = %s and typ = %s and iid = %s
                """, (str(item["rate"]), item["name"], item["typ"], str(item["iid"])))
            if "comment" in item:
                conn.execute("""
                update record
                set comment = %s
                where name = %s and typ = %s and iid = %s
                """, (item["comment"], item["name"], item["typ"], str(item["iid"])))
            if "tags" in item:
                conn.execute("""
                update record
                set tags = %s
                where name = %s and typ = %s and iid = %s
                """, (u' '.join(item["tags"]), item["name"], item["typ"], str(item["iid"])))

    def _handle_error(self, failure, item, spider):
        """Handle occurred on db interaction."""
        # do nothing, just log
        log.err(failure)
