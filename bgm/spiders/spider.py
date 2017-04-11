# -*- coding: utf-8 -*-

import scrapy
import re
from bgm.items import Record, Index, Friend, User, SubjectInfo, Subject
from bgm.util import *
from scrapy.http import Request
import datetime


class UserSpider(scrapy.Spider):
    name = 'user'
    def __init__(self, *args, **kwargs):
        super(UserSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max=400000
        if not hasattr(self, 'id_min'):
            self.id_min=1
        self.start_urls = ["http://chii.in/user/"+str(i) for i in xrange(int(self.id_min),int(self.id_max))]

    def parse(self, response):
        if len(response.xpath(".//*[@id='headerProfile']"))==0:
            return
        user = response.xpath(".//*[@id='headerProfile']/div/div/h1/div[3]/small/text()").extract()[0][1:]
        nickname = response.xpath(".//*[@class='headerContainer']//*[@class='inner']/a/text()").extract()[0]

        # Is blocked?
        if len(response.xpath("//ul[@class='timeline']/li"))==0:
            return;

        if not 'redirect_urls' in response.meta:
            uid = int(user)
        else:
            uid = int(response.meta['redirect_urls'][0].split('/')[-1])
        date = response.xpath(".//*[@id='user_home']/div[@class='user_box clearit']/ul/li[1]/span[2]/text()").extract()[0].split(' ')[0]
        date = parsedate(date)
        last_timestamp = response.xpath(".//*[@id='columnB']/div[1]/div/ul/li[1]/small[2]/text()").extract()[0].split()
        if last_timestamp[-1]==u'ago':
            last_active = datetime.date.today()
        else:
            last_active = parsedate(last_timestamp[0])

        yield User(name=user, nickname=nickname, uid=uid, joindate=date, activedate=last_active)

class IndexSpider(scrapy.Spider):
    name='index'
    def __init__(self, *args, **kwargs):
        super(IndexSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max=20000
        if not hasattr(self, 'id_min'):
            self.id_min=1
        self.start_urls = ["http://chii.in/index/"+str(i) for i in xrange(int(self.id_min),int(self.id_max))]

    def parse(self, response):
        if len(response.xpath(".//*[@id='columnSubjectBrowserA']/div[1]/a"))==0:
            return
        indexid = response.url.split('/')[-1]
        indexid=int(indexid)
        creator = response.xpath(".//*[@id='columnSubjectBrowserA']/div[1]/a/@href").extract()[0].split('/')[-1]
        creator=str(creator)
        td = response.xpath(".//*[@id='columnSubjectBrowserA']/div[1]/span/span[1]/text()").extract()[0]
        date = parsedate(td.split(' ')[0])
        if len(response.xpath(".//*[@id='columnSubjectBrowserA']/div[1]/span/span"))==2:
            favourite = response.xpath(".//*[@id='columnSubjectBrowserA']/div[1]/span/span[2]/text()").extract()[0]
            favourite = int(favourite)
        else: favourite = 0
        items = response.xpath(".//*[@id='columnSubjectBrowserA']/ul/li/@id").extract()
        items = [int(itm.split('_')[-1]) for itm in items]
        yield Index(indexid=indexid, creator=creator, favourite=favourite, date=date, items=items)

class RecordSpider(scrapy.Spider):
    name='record'
    def __init__(self, *args, **kwargs):
        super(RecordSpider, self).__init__(*args, **kwargs)
        if hasattr(self, 'type'):
            tplst = [itm.strip().lower() for itm in self.type.split(',')]
        else:
            tplst = ['anime', 'book', 'music', 'game', 'real']
        if hasattr(self, 'userlist'):
            userlist = []
            with open(self.userlist, 'r') as fr:
                while True:
                    l = fr.readline().strip()
                    if not l: break;
                    userlist.append(l)
            self.start_urls = ["http://chii.in/{0}/list/{1}".format(tp, i) for i in userlist for tp in tplst]
        else:
            if not hasattr(self, 'id_max'):
                self.id_max=400000
            if not hasattr(self, 'id_min'):
                self.id_min=1
            self.start_urls = ["http://chii.in/{0}/list/{1}".format(tp, str(i)) for i in xrange(int(self.id_min),int(self.id_max)) for tp in tplst]

    def parse(self, response):
        username = response.url.split('/')[-1]
        if not 'redirect_urls' in response.meta:
            uid = int(username)
        else:
            uid = int(response.meta['redirect_urls'][0].split('/')[-1])

        followlinks = response.xpath(".//div[@id='columnA']/div/div[1]/ul/li[2]//@href").extract() # a list of links
        for link in followlinks:
            req = scrapy.Request(u"http://chii.in"+link, callback = self.parse_recorder)
            req.meta['uid']=uid
            yield req

    def parse_recorder(self, response):
        name = response.url.split('/')[-2]
        uid = response.meta['uid']
        state = response.url.split('/')[-1].split('?')[0]
        tp = response.url.split('/')[-4]

        items = response.xpath(".//*[@id='browserItemList']/li")
        for item in items:
            item_id = int(re.match(r"item_(\d+)",item.xpath("./@id").extract()[0]).group(1))
            item_date = parsedate(item.xpath("./div/p[@class='collectInfo']/span[@class='tip_j']/text()").extract()[0])
            if item.xpath("./div/p[@class='collectInfo']/span[@class='tip']"):
                item_tags = item.xpath("./div/p[@class='collectInfo']/span[@class='tip']/text()").extract()[0].split(u' ')[2:-1]
            else:
                item_tags=None

            try_match = re.match(r'sstars(\d+) starsinfo', item.xpath("./div/p[@class='collectInfo']/span[1]/@class").extract()[0])
            if try_match:
                item_rate = try_match.group(1)
                item_rate = int(item_rate)
            else:
                item_rate = None

            watchRecord = Record(name = name, uid = uid, typ = tp, state = state, iid = item_id, adddate = item_date)
            if item_tags:
                watchRecord["tags"]=item_tags
            if item_rate:
                watchRecord["rate"]=item_rate
            yield watchRecord

        if len(items)==24:
            request = scrapy.Request(getnextpage(response.url),callback = self.parse_recorder)
            request.meta['uid']=uid
            yield request

class FriendsSpider(scrapy.Spider):
    name='friends'
    handle_httpstatus_list = [302]
    def __init__(self, *args, **kwargs):
        super(FriendsSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max=400000
        if not hasattr(self, 'id_min'):
            self.id_min=1
        self.start_urls = ["http://chii.in/user/"+str(i)+"/friends" for i in xrange(int(self.id_min),int(self.id_max))]

    def parse(self, response):
        user = response.url.split('/')[-2]
        lst = response.xpath(".//*[@id='memberUserList']/li//@href").extract()
        for itm in lst:
            yield Friend(user = user, friend = str(itm.split('/')[-1]))

class SubjectInfoSpider(scrapy.Spider):
    name="subjectinfo"
    def __init__(self, *args, **kwargs):
        super(SubjectInfoSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max=200000
        if not hasattr(self, 'id_min'):
            self.id_min=1
        self.start_urls = ["http://chii.in/subject/"+str(i) for i in xrange(int(self.id_min),int(self.id_max))]

    def make_requests_from_url(self, url):
        rtn = Request(url)
        rtn.meta['dont_redirect']=True
        return rtn;

    def parse(self, response):
        subject_id = int(response.url.split('/')[-1])
        if not response.xpath(".//*[@id='headerSubject']"):
            return
        if response.xpath(".//div[@class='tipIntro']"):
            return
        typestring = response.xpath(".//div[@class='global_score']/div/small[1]/text()").extract()[0]
        typestring = typestring.split(' ')[1];

        infobox = [itm.extract()[:-2] for itm in response.xpath(".//div[@class='infobox']//span/text()")]
        infobox = set(infobox)

        relations = [itm.extract() for itm in response.xpath(".//ul[@class='browserCoverMedium clearit']/li[@class='sep']/span/text()")]
        relations = set(relations)

        yield SubjectInfo(subjectid=subject_id,
                          subjecttype=typestring,
                          infobox=infobox,
                          relations=relations)

class SubjectSpider(scrapy.Spider):
    name="subject"
    def __init__(self, *args, **kwargs):
        super(SubjectSpider, self).__init__(*args, **kwargs)
        if hasattr(self, 'itemlist'):
            itemlist = []
            with open(self.itemlist, 'r') as fr:
                while True:
                    l = fr.readline().strip()
                    if not l: break;
                    itemlist.append(l)
            self.start_urls = ["http://chii.in/subject/"+i for i in itemlist]
        else:
            if not hasattr(self, 'id_max'):
                self.id_max=200000
            if not hasattr(self, 'id_min'):
                self.id_min=1
            self.start_urls = ["http://chii.in/subject/"+str(i) for i in xrange(int(self.id_min),int(self.id_max))]
    

    def make_requests_from_url(self, url):
        rtn = Request(url)
        # rtn.meta['dont_redirect']=True
        return rtn;

    def parse(self, response):
        subjectid = int(response.url.split('/')[-1]) # trueid
        if not response.xpath(".//*[@id='headerSubject']"):
            return
        
        # This is used to filter those locked items
        # However, considering that current Bangumi ranking list does not exclude blocked items,
        # we include them in our spider.
        #if response.xpath(".//div[@class='tipIntro']"):
        #    return;

        if 'redirect_urls' in response.meta:
            authenticid = int(response.meta['redirect_urls'][0].split('/')[-1])
        else:
            authenticid = subjectid; # id

        subjecttype = response.xpath(".//div[@class='global_score']/div/small[1]/text()").extract()[0]
        subjecttype = subjecttype.split(' ')[1].lower();

        subjectname = response.xpath(".//*[@id='headerSubject']/h1/a/attribute::title").extract()[0]
        if not subjectname:
            subjectname = response.xpath(".//*[@id='headerSubject']/h1/a/text()").extract()[0]

        rank = response.xpath(".//div[@class='global_score']/div/small[2]/text()").extract()[0]
        if rank==u'--':
            rank=None;
        else:
            rank = int(rank[1:])
        votenum = int(response.xpath(".//*[@id='ChartWarpper']/div/small/span/text()").extract()[0])

        tplst = [itm.split('/')[-1] for itm in response.xpath(".//*[@id='columnSubjectHomeA']/div[3]/span/a/@href").extract()]
        favcount = [0]*5; j=1;
        for i in xrange(5):
            if not tplst or tplst[0]!=statestr[i]:
                favcount[i]=0;
            else:
                tmpstr = response.xpath(".//*[@id='columnSubjectHomeA']/div[3]/span/a["+str(j)+"]/text()").extract()[0]
                mtch = re.match(ur"^(\d+)", tmpstr);
                favcount[i] = int(mtch.group());
                j+=1
                tplst = tplst[1:]

        infokey = [itm[:-2] for itm in response.xpath(".//div[@class='infobox']//li/span/text()").extract()]
        infoval = response.xpath(".//div[@class='infobox']//li")
        infobox = dict()
        for key,val in zip(infokey, infoval):
            if val.xpath("a"):
                infobox[key]=[int(ref.split('/')[-1]) for ref in
                      val.xpath("a/@href").extract()]

        date = None
        for datekey in datestr:
            if datekey in infokey:
                idx = infokey.index(datekey)
                try:
                    date = parsedate(infoval[idx].xpath('text()').extract()[0]) #may be none
                except:
                    date = None;
            if date is None:
                continue;
            else: break;

        relateditms = response.xpath(".//ul[@class='browserCoverMedium clearit']/li")
        relations = dict()
        for itm in relateditms:
            if itm.xpath("@class"):
                relationtype = itm.xpath("span/text()").extract()[0]
                relations[relationtype]=[int(itm.xpath("a[@class='title']/@href").
                                extract()[0].split('/')[-1])]
            else:
                relations[relationtype].append(int(itm.xpath("a[@class='title']/@href").
                                      extract()[0].split('/')[-1]))
        brouche = response.xpath(".//ul[@class='browserCoverSmall clearit']/li")
        if brouche:
            relations[u'单行本']=[int(itm.split('/')[-1]) for itm in
                           brouche.xpath("a/@href").extract()]

        tagbox = response.xpath(".//div[@class='subject_tag_section']/div")
        tagname = tagbox.xpath("a/text()").extract()
        tagval = [int(itm) for itm in tagbox.xpath("small").re("\d+")]
        tags = dict(zip(tagname,tagval))

        yield Subject(subjectid=subjectid,
                      subjecttype=subjecttype,
                      subjectname=subjectname,
                      authenticid=authenticid,
                      rank=rank,
                      votenum=votenum,
                      favnum=favcount,
                      date=date,
                      #staff=infobox,
                      relations=relations,
                      tags=tags)
