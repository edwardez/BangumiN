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
    anime = scrapy.Field()
    game = scrapy.Field()
    book = scrapy.Field()
    music = scrapy.Field()
    drama = scrapy.Field()


