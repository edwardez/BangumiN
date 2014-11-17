import scrapy
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
            yield scrapy.Request("http://chii.in/anime/list/"+username, self.parse_record)
            itm["anime"]=self.anime

    def record_reader(self, response):
        pass