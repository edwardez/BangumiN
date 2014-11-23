import scrapy
import re
from bgm.items import BgmUser
from bgm.util import Record,parsedate,getnextpage

class recordspider(scrapy.Spider):
    name = "record"
    
    def __init__(self, max_id = 300000):
        self.start_urls = ["http://chii.in/user/"+str(i+1) for i in xrange(int(max_id))]
        self.temp=[]


    def parse(self, response):
        username = response.url.split('/')[-1]
        userid = response.meta['redirect_urls'][0].split('/')[-1]
        itm = BgmUser()
        itm["uid"] = int(userid)
        itm["name"] = username
        d = response.xpath(".//*[@id='user_home']/div[1]/div[2]/p[2]/text()").extract()[0].split(' ')[0]
        itm["joindate"] = parsedate(d)

        if len(response.xpath(".//*[@id='anime']")):
            yield scrapy.Request("http://chii.in/anime/list/"+username, callback = self.merge)
            itm["anime"]=self.temp
            self.temp=[]

        if len(response.xpath(".//*[@id='game']")):
            yield scrapy.Request("http://chii.in/game/list/"+username, callback = self.merge)
            itm["game"]=self.temp
            self.temp=[]

        if len(response.xpath(".//*[@id='book']")):
            yield scrapy.Request("http://chii.in/book/list/"+username, callback = self.merge)
            itm["book"]=self.temp
            self.temp=[]

        if len(response.xpath(".//*[@id='music']")):
            yield scrapy.Request("http://chii.in/music/list/"+username, callback = self.merge)
            itm["music"]=self.temp
            self.temp=[]

        if len(response.xpath(".//*[@id='drama']")):
            yield scrapy.Request("http://chii.in/drama/list/"+username, callback = self.merge)
            itm["drama"]=self.temp
            self.temp=[]

        yield itm

    def merge(self, response):
        head = response.xpath(".//*[@id='header']/div/ul[2]/li/a[@href]").extract() # a list of links
        for link in head:
            if re.search(r"wish",link):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="wish"
                request.meta["count"]=num
                yield request
            elif re.search(r"collect",link):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="collect"
                request.meta["count"]=num
                yield request
            elif re.search(r"do",link):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="do"
                request.meta["count"]=num
                yield request
            elif re.search(r"on_hold",link):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="on_hold"
                request.meta["count"]=num
                yield request
            elif re.search(r"dropped",link):
                num = int(re.search(r"(\d+)",link).group(1))
                follow = "http://chii.in"+str(re.search(r'href="([/-_\w]+)"',link).group(1))
                request = scrapy.Request(follow, callback = self.parse_recorder)
                request.meta["type"]="dropped"
                request.meta["count"]=num
                yield request

    def parse_recorder(self, response):
        tp = response.meta["type"]
        cnt = response.meta["count"]

        items = response.xpath(".//*[@id='browserItemList']/li")
        for item in items:
            if not cnt: break

            item_id = int(re.match(r"item_(\d+)",item.xpath("./@id").extract()[0]).group(1))
            item_date = parsedate(item.xpath("./div/p[@class='collectInfo']/span[@class='tip_j']/text()").extract()[0])
            item_state = tp
            if item.xpath("./div/p[@class='collectInfo']/span[@class='tip']"):
                item_tags = item.xpath("./div/p[@class='collectInfo']/span[@class='tip']/text()").extract()[0].split(u' ')[1:-1]
            else:
                item_tags=None

            try_match = re.match(r'sstars(\d+) starsinfo', item.xpath("./div/p[@class='collectInfo']/span[1]/@class").extract()[0])
            if try_match:
                item_rate = try_match.group(1)
            else:
                item_rate = None

            if item.xpath("./div/p[@class='collectInfo']/div"):
                item_comment = item.xpath(".//*[@id='comment_box']/div/div/div[1]/text()").extract()[0]
            else:
                item_comment = None

            self.temp.append(Record(item_id, item_date, item_state, item_rate, item_comment, item_tags))
            --cnt

        if not cnt:
            request = scrapy.Request(getnextpage(response.url),callback = self.parse_recorder)
            request.meta["type"]=tp
            request.meta["count"]=cnt
            yield request