# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class BgmUser(scrapy.Item):
    uid = scrapy.Field()
    name = scrapy.Field()
    joindate = scrapy.Field()

class WatchRecord(scrapy.Item):
    ## First five items are required.
    name = scrapy.Field()
    typ = scrapy.Field()
    iid = scrapy.Field()
    state = scrapy.Field()
    date = scrapy.Field()
    ## Following three are optional.
    rate = scrapy.Field()
    comment = scrapy.Field()
    tags = scrapy.Field()


