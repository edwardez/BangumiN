import scrapy
import re
from bgm.items import BgmUser
from bgm.util import Record
from datetime import date

class recordspider(scrapy.Spider):
    name = "record"
    
    def __init__(self, max_id = 300000):
        self.start_url = ["http://chii.in/user/"+str(i+1) for i in xrange(max_id)]
        self.anime=[]


    def parse(self, response):
        username = response.url.split('/')[-1]
        userid = request.url.split('/')[-1]
        itm = BgmUser()
        itm["uid"] = int(userid)
        itm["name"] = username
        d = response.xpath(".//*[@id='user_home']/div[1]/div[2]/p[2]/text()").extract()[0].split(' ')[0]
        itm["joindate"] = date(int(d.split('-')[0]), int(d.split('-')[1]), int(d.split('-')[2]))

        if len(response.xpath(".//*[@id='anime']")):
            yield scrapy.Request("http://chii.in/anime/list/"+username, callback = self.merge)
            itm["anime"]=self.anime

    def merge(self, response):
        head = response.xpath(".//*[@id='header']/div/ul[2]/li/a[@href]").extract() # a list of links
        for link in head:
            if re.search("wish"):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="wish"
                request.meta["count"]=num
                yield request
            elif re.search("collect"):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="collect"
                request.meta["count"]=num
                yield request
            elif re.search("do"):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="do"
                request.meta["count"]=num
                yield request
            elif re.search("on_hold"):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="on_hold"
                request.meta["count"]=num
                yield request
            else re.search("dropped"):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="dropped"
                request.meta["count"]=num
                yield request

    def parse_recorder(self, response):
        