# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy

class Record(scrapy.Item):
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

class Index(scrapy.Item):
    indexid = scrapy.Field()
    creator = scrapy.Field()
    favourite = scrapy.Field()
    date = scrapy.Field()
    items = scrapy.Field()

class Friend(scrapy.Item):
    """This item keeps a directed relationship that user is following his/her friend."""
    user = scrapy.Field()
    friend = scrapy.Field()
    # No date information
