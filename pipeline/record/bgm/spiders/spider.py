# -*- coding: utf-8 -*-

import logging

import scrapy
from dateutil import tz
from dateutil.parser import parse

logger = logging.getLogger(__name__)
from record.bgm.items import Record, Index, Friend, User, SubjectInfo, Subject, \
    WikiHistory
from record.bgm.util import *

mpa = dict([(i, None) for i in range(32)])

UTC = tz.tzutc()


class UserSpider(scrapy.Spider):
    # User spider may be deprecated, since api.bgm.tv contains more information
    name = 'user'

    def __init__(self, *args, **kwargs):
        super(UserSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max = 400000
        if not hasattr(self, 'id_min'):
            self.id_min = 1
        self.start_urls = ["https://bgm.tv/user/" + str(i) for i in
                           range(int(self.id_min), int(self.id_max))]

    def parse(self, response):
        if len(response.xpath(".//*[@id='headerProfile']")) == 0:
            return
        user = response.xpath(
            ".//*[@id='headerProfile']/div/div/h1/div[3]/small/text()").extract()[
                   0][1:]
        nickname = response.xpath(
            ".//*[@class='headerContainer']//*[@class='inner']/a/text()").extract()[
            0].translate(
            mpa)

        # Is blocked?
        if len(response.xpath("//ul[@class='timeline']/li")) == 0:
            return

        if not 'redirect_urls' in response.meta:
            uid = int(user)
        else:
            uid = int(response.meta['redirect_urls'][0].split('/')[-1])
        date = response.xpath(
            ".//*[@id='user_home']/div[@class='user_box clearit']/ul/li[1]/span[2]/text()").extract()[
            0].split(' ')[0]
        date = parsedate(date)
        last_timestamp = response.xpath(
            ".//*[@id='columnB']/div[1]/div/ul/li[1]/small[2]/text()").extract()[
            0].split()
        if last_timestamp[-1] == u'ago':
            last_active = datetime.date.today()
        else:
            last_active = parsedate(last_timestamp[0])

        yield User(name=user, nickname=nickname, uid=uid, joindate=date,
                   activedate=last_active)


class IndexSpider(scrapy.Spider):
    name = 'index'

    def __init__(self, *args, **kwargs):
        super(IndexSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max = 20000
        if not hasattr(self, 'id_min'):
            self.id_min = 1
        self.start_urls = ["https://bgm.tv/index/" + str(i) for i in
                           range(int(self.id_min), int(self.id_max))]

    def parse(self, response):
        if len(
                response.xpath(".//*[@id='columnSubjectBrowserA']/div[1]/a")) == 0:
            return
        indexid = response.url.split('/')[-1]
        indexid = int(indexid)
        creator = response.xpath(
            ".//*[@id='columnSubjectBrowserA']/div[1]/a/@href").extract()[
            0].split('/')[-1]
        creator = str(creator).translate(mpa)
        td = response.xpath(
            ".//*[@id='columnSubjectBrowserA']/div[1]/span/span[1]/text()").extract()[
            0]
        date = parsedate(td.split(' ')[0])
        if len(response.xpath(
                ".//*[@id='columnSubjectBrowserA']/div[1]/span/span")) == 2:
            favourite = response.xpath(
                ".//*[@id='columnSubjectBrowserA']/div[1]/span/span[2]/text()").extract()[
                0]
            favourite = int(favourite)
        else:
            favourite = 0
        items = response.xpath(
            ".//*[@id='columnSubjectBrowserA']/ul/li/@id").extract()
        items = [int(itm.split('_')[-1]) for itm in items]
        yield Index(indexid=indexid, creator=creator, favourite=favourite,
                    date=date, items=items)


class RecordSpider(scrapy.Spider):
    name = 'record'
    custom_settings = {
        'ITEM_PIPELINES': {
            'record.bgm.pipelines.DBPipeline': 800
        }
    }

    def __init__(self, user_id_min=None, user_id_max=None, excluding_list=(),
                 *args, **kwargs):
        """
        Initalize spider
        :param user_id_min: passed in user_id_min
        :param user_id_max: passed in user_id_max
        :param args:
        :param kwargs:
        """
        super(RecordSpider, self).__init__(*args, **kwargs)
        if hasattr(self, 'userlist'):
            userlist = []
            with open(self.userlist, 'r') as fr:
                while True:
                    l = fr.readline().strip()
                    if not l: break
                    userlist.append(l)
            self.start_urls = ["https://bgm.tv/user/" + i for i in userlist]
            logger.info('Starting scarping in user list %s ...', userlist[:3])
        else:
            if user_id_min is not None and user_id_max is not None:
                self.id_min = user_id_min
                self.id_max = user_id_max

            else:
                if not hasattr(self, 'id_max'):
                    self.id_max = 500000
                if not hasattr(self, 'id_min'):
                    self.id_min = 1

            self.start_urls = ["https://bgm.tv/user/" + str(i) for i in
                               range(int(self.id_min), int(self.id_max)) if
                               i not in excluding_list]
            logger.info('Starting scarping in user id range (%s, %s)',
                        self.id_min, self.id_max)

    def parse(self, response):
        username = response.url.split('/')[-1]
        if (not response.xpath(".//*[@id='headerProfile']")) or response.xpath(
                ".//div[@class='tipIntro']"):
            return
        uid = int(response.meta['redirect_urls'][0].split('/')[
                      -1]) if 'redirect_urls' in response.meta else int(
            username)

        if len(response.xpath(".//*[@id='anime']")):
            yield scrapy.Request("https://bgm.tv/anime/list/" + username,
                                 callback=self.merge,
                                 meta={'uid': uid})

        if len(response.xpath(".//*[@id='game']")):
            yield scrapy.Request("https://bgm.tv/game/list/" + username,
                                 callback=self.merge,
                                 meta={'uid': uid})

        if len(response.xpath(".//*[@id='book']")):
            yield scrapy.Request("https://bgm.tv/book/list/" + username,
                                 callback=self.merge,
                                 meta={'uid': uid})

        if len(response.xpath(".//*[@id='music']")):
            yield scrapy.Request("https://bgm.tv/music/list/" + username,
                                 callback=self.merge,
                                 meta={'uid': uid})

        if len(response.xpath(".//*[@id='real']")):
            yield scrapy.Request("https://bgm.tv/real/list/" + username,
                                 callback=self.merge,
                                 meta={'uid': uid})

    def merge(self, response):
        followlinks = response.xpath(
            ".//div[@id='columnA']/div/div[1]/ul/li[1]/h2//@href").extract()  # a list of links
        for link in followlinks:
            yield scrapy.Request(u"https://bgm.tv" + link,
                                 callback=self.parse_recorder,
                                 meta={'uid': response.meta['uid']})

    def parse_recorder(self, response):
        username = response.url.split('/')[-2]
        nickname = response.xpath(
            ".//div[@id='headerProfile']//h1/div[3]/a/text()").extract()[
            0].translate(mpa)
        state = response.url.split('/')[-1].split('?')[0]
        tp = response.url.split('/')[-4]

        items = response.xpath(".//*[@id='browserItemList']/li")
        for item in items:
            item_id = int(
                re.match(r"item_(\d+)", item.xpath("./@id").extract()[0]).group(
                    1))
            item_date = parsedate(item.xpath(
                "./div/p[@class='collectInfo']/span[@class='tip_j']/text()").extract()[
                                      0])
            if item.xpath("./div/p[@class='collectInfo']/span[@class='tip']"):
                item_tags = item.xpath(
                    "./div/p[@class='collectInfo']/span[@class='tip']/text()").extract()[
                                0].split(
                    u' ')[2:-1]
            else:
                item_tags = None

            star_class_name_or_empty = next(iter(item.xpath(
                "./div/p[@class='collectInfo']/span[1]/span/@class").extract()), '')
            try_match = re.search(r'star[A-Za-z\-_]*(\d+)', star_class_name_or_empty)
            if try_match:
                item_rate = try_match.group(1)
                item_rate = int(item_rate)
            else:
                item_rate = None

            comment = item.xpath(".//div[@class='text']/text()").extract()[
                0] if len(
                item.xpath(".//div[@class='text']")) > 0 else None

            watchRecord = Record(nickname=nickname, name=username,
                                 uid=response.meta['uid'],
                                 typ=tp, state=state, iid=item_id,
                                 adddate=item_date)
            if item_tags:
                watchRecord["tags"] = item_tags
            if item_rate:
                watchRecord["rate"] = item_rate
            if comment:
                watchRecord["comment"] = comment.translate(mpa)
            yield watchRecord

        if len(items) == 24:
            yield scrapy.Request(getnextpage(response.url),
                                 callback=self.parse_recorder,
                                 meta={'uid': response.meta['uid']})


class WikiHistorySpider(scrapy.Spider):
    name = 'wiki'
    custom_settings = {
        'ITEM_PIPELINES': {
            'record.bgm.pipelines.WikiHistoryDBPipeline': 800
        }
    }

    def __init__(self, user_id_min=None, user_id_max=None, excluding_list=(),
                 *args, **kwargs):
        """
        Initalize spider
        :param user_id_min: passed in user_id_min
        :param user_id_max: passed in user_id_max
        :param args:
        :param kwargs:
        """
        super(WikiHistorySpider, self).__init__(*args, **kwargs)

        if hasattr(self, 'userlist'):
            userlist = []
            with open(self.userlist, 'r') as fr:
                while True:
                    l = fr.readline().strip()
                    if not l: break
                    userlist.append(l)
            self.start_urls = ["https://bgm.tv/user/" + str(i) + "/wiki" for i
                               in userlist]
            logger.info('Starting scarping in user list %s ...', userlist[:3])
        else:
            if user_id_min is not None and user_id_max is not None:
                self.id_min = user_id_min
                self.id_max = user_id_max

            else:
                if not hasattr(self, 'id_max'):
                    self.id_max = 500000
                if not hasattr(self, 'id_min'):
                    self.id_min = 1

            self.start_urls = ["https://bgm.tv/user/" + str(i) + "/wiki" for i
                               in
                               range(int(self.id_min), int(self.id_max)) if
                               i not in excluding_list]
            logger.info('Starting scarping in user id range (%s, %s)',
                        self.id_min, self.id_max)

    def parse(self, response):
        username = response.url.split('/')[-2]

        if (not response.xpath(".//*[@id='headerProfile']")) or response.xpath(
                ".//div[@class='tipIntro']"):
            return

        user_id = int(response.meta['redirect_urls'][0].split('/')[
                          -2]) if 'redirect_urls' in response.meta else int(
            username)

        common_meta = {'username': username, 'user_id': user_id}

        yield scrapy.Request("https://bgm.tv/user/" + username + "/wiki",
                             callback=self.parse_wiki_history,
                             meta={**common_meta, **{'edit_type': 'subject'}})

        yield scrapy.Request(
            "https://bgm.tv/user/" + username + "/wiki/character",
            callback=self.parse_wiki_history,
            meta={**common_meta, **{'edit_type': 'character'}})

        yield scrapy.Request("https://bgm.tv/user/" + username + "/wiki/person",
                             callback=self.parse_wiki_history,
                             meta={**common_meta,
                                   **{'edit_type': 'person'}})

        yield scrapy.Request("https://bgm.tv/user/" + username + "/wiki/ep",
                             callback=self.parse_wiki_history,
                             meta={**common_meta, **{'edit_type': 'ep'}})

        yield scrapy.Request(
            "https://bgm.tv/user/" + username + "/wiki/subject_relation",
            callback=self.parse_wiki_history,
            meta={**common_meta, **{'edit_type': 'subject_relation'}})

        yield scrapy.Request(
            "https://bgm.tv/user/" + username + "/wiki/subject_person_relation",
            callback=self.parse_wiki_history,
            meta={**common_meta, **{'edit_type': 'subject_person_relation'}})

        yield scrapy.Request(
            "https://bgm.tv/user/" + username + "/wiki/subject_character_relation",
            callback=self.parse_wiki_history,
            meta={**common_meta, **{'edit_type': 'subject_character_relation'}})

    def parse_wiki_history(self, response):
        items = response.xpath(
            ".//div[@id='columnA']//ul[@class='line_list']/li")
        for item in items:
            entry_type = WikiHistorySpider.edit_type_to_entry_type(
                response.meta['edit_type'])

            matched_entry_id = re.match("/\w+/(\d+$)", item.xpath(
                f".//a[contains(@href,{entry_type})][1]/@href").extract()[
                0])
            entry_id = int(matched_entry_id.group(
                1)) if matched_entry_id is not None else None

            edit_time = None
            extracted_time = None
            try:
                extracted_time = item.xpath(".//cite[1]//text()").extract()[0]
                edit_time = parse(f"{extracted_time}+08:00").astimezone(UTC)
            except Exception as exception:
                logger.error(f"Malformed edit %s time {extracted_time}")
                logger.error(exception)

            comments = item.xpath(
                ".//span[contains(@class, 'tip_j')][1]/text()").extract()
            edit_comment = re.sub('^\\(|\\)$', '', comments[0]) if len(
                comments) > 0 else None
            edit_type = response.meta['edit_type']

            wiki_history = WikiHistory(
                user_id=response.meta['user_id'],
                entry_id=entry_id,
                edit_comment=edit_comment,
                edit_time=edit_time,
                edit_type=edit_type)

            yield wiki_history

        # there're 50 records in same page, which implies we might need to check next page
        if len(items) == 50:
            yield scrapy.Request(getnextpage(response.url),
                                 callback=self.parse_wiki_history,
                                 meta=response.meta)

    @staticmethod
    def edit_type_to_entry_type(edit_type):
        return {
            'subject': 'subject',
            'character': 'character',
            'person': 'person',
            'ep': 'ep',
            'subject_relation': 'subject',
            'subject_person_relation': 'subject',
            'subject_character_relation': 'subject'
        }[edit_type]


class FriendsSpider(scrapy.Spider):
    name = 'friends'
    handle_httpstatus_list = [302]

    def __init__(self, *args, **kwargs):
        super(FriendsSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max = 400000
        if not hasattr(self, 'id_min'):
            self.id_min = 1
        self.start_urls = ["https://bgm.tv/user/" + str(i) + "/friends" for i in
                           range(int(self.id_min), int(self.id_max))]

    def parse(self, response):
        user = response.url.split('/')[-2]
        lst = response.xpath(".//*[@id='memberUserList']/li//@href").extract()
        for itm in lst:
            yield Friend(user=user, friend=str(itm.split('/')[-1]))


class SubjectInfoSpider(scrapy.Spider):
    name = "subjectinfo"

    def __init__(self, *args, **kwargs):
        super(SubjectInfoSpider, self).__init__(*args, **kwargs)
        if not hasattr(self, 'id_max'):
            self.id_max = 300000
        if not hasattr(self, 'id_min'):
            self.id_min = 1
        self.start_urls = ["https://bgm.tv/subject/" + str(i) for i in
                           range(int(self.id_min), int(self.id_max))]

    def parse(self, response):
        subject_id = int(response.url.split('/')[-1])
        if not response.xpath(".//*[@id='headerSubject']"):
            return
        if response.xpath(".//div[@class='tipIntro']"):
            return
        typestring = response.xpath(
            ".//div[@class='global_score']/div/small[1]/text()").extract()[0]
        typestring = typestring.split(' ')[1]

        infobox = [itm.extract()[:-2] for itm in
                   response.xpath(".//div[@class='infobox']//span/text()")]
        infobox = set(infobox)

        relations = [itm.extract() for itm in
                     response.xpath(
                         ".//ul[@class='browserCoverMedium clearit']/li[@class='sep']/span/text()")]
        relations = set(relations)

        yield SubjectInfo(subjectid=subject_id,
                          subjecttype=typestring,
                          infobox=infobox,
                          relations=relations)


class SubjectSpider(scrapy.Spider):
    name = "subject"

    def __init__(self, *args, **kwargs):
        super(SubjectSpider, self).__init__(*args, **kwargs)
        if hasattr(self, 'itemlist'):
            itemlist = []
            with open(self.itemlist, 'r') as fr:
                while True:
                    l = fr.readline().strip()
                    if not l: break
                    itemlist.append(l)
            self.start_urls = ["https://bgm.tv/subject/" + i for i in itemlist]
        else:
            if not hasattr(self, 'id_max'):
                self.id_max = 300000
            if not hasattr(self, 'id_min'):
                self.id_min = 1
            self.start_urls = ["https://bgm.tv/subject/" + str(i) for i in
                               range(int(self.id_min), int(self.id_max))]

    def parse(self, response):
        subjectid = int(response.url.split('/')[-1])  # trueid
        if not response.xpath(".//*[@id='headerSubject']"):
            return

        # This is used to filter those locked items
        # However, considering that current Bangumi ranking list does not exclude blocked items,
        # we include them in our spider.
        # if response.xpath(".//div[@class='tipIntro']"):
        #    return

        if 'redirect_urls' in response.meta:
            order = int(response.meta['redirect_urls'][0].split('/')[-1])
        else:
            order = subjectid  # id

        subjecttype = response.xpath(
            ".//div[@class='global_score']/div/small[1]/text()").extract()[0]
        subjecttype = subjecttype.split(' ')[1].lower()

        subjectname = response.xpath(
            ".//*[@id='headerSubject']/h1/a/attribute::title").extract()[0]
        if not subjectname:
            subjectname = \
                response.xpath(
                    ".//*[@id='headerSubject']/h1/a/text()").extract()[0]

        rank = response.xpath(
            ".//div[@class='global_score']/div/small[2]/text()").extract()[0]
        if rank == u'--':
            rank = None
        else:
            rank = int(rank[1:])
        votenum = int(response.xpath(
            ".//*[@id='ChartWarpper']/div/small/span/text()").extract()[0])

        tplst = [itm.split('/')[-1] for itm in
                 response.xpath(
                     ".//*[@id='columnSubjectHomeA']/div[3]/span/a/@href").extract()]
        favcount = [0] * 5
        j = 1
        for i in range(5):
            if not tplst or tplst[0] != statestr[i]:
                favcount[i] = 0
            else:
                tmpstr = \
                    response.xpath(
                        ".//*[@id='columnSubjectHomeA']/div[3]/span/a[" + str(
                            j) + "]/text()").extract()[0]
                mtch = re.match(r"^(\d+)", tmpstr)
                favcount[i] = int(mtch.group())
                j += 1
                tplst = tplst[1:]

        infokey = [itm[:-2] for itm in response.xpath(
            ".//div[@class='infobox']//li/span/text()").extract()]
        infoval = response.xpath(".//div[@class='infobox']//li")
        infobox = dict()
        for key, val in zip(infokey, infoval):
            if val.xpath("a"):
                infobox[key] = [ref.split('/')[-1] for ref in
                                val.xpath("a/@href").extract()]

        date = None
        for datekey in datestr:
            if datekey in infokey:
                idx = infokey.index(datekey)
                try:
                    date = parsedate(infoval[idx].xpath('text()').extract()[
                                         0])  # may be none
                except:
                    date = None
            if date is None:
                continue
            else:
                break

        relateditms = response.xpath(
            ".//ul[@class='browserCoverMedium clearit']/li")
        relations = dict()
        for itm in relateditms:
            relation_type = itm.xpath("span/text()").extract()[0]
            if itm.xpath("@class"):
                relation_type = itm.xpath("span/text()").extract()[0]
                relations[relation_type] = [
                    itm.xpath("a[@class='title']/@href").
                        extract()[0].split('/')[-1]]
            else:
                relations[relation_type].append(
                    itm.xpath("a[@class='title']/@href").
                        extract()[0].split('/')[-1])
        brouche = response.xpath(".//ul[@class='browserCoverSmall clearit']/li")
        if brouche:
            relations['单行本'] = [itm.split('/')[-1] for itm in
                                brouche.xpath("a/@href").extract()]

        yield Subject(subjectid=subjectid,
                      subjecttype=subjecttype,
                      subjectname=subjectname.translate(mpa),
                      order=order,
                      rank=rank,
                      votenum=votenum,
                      favnum=''.join([str(itm) for itm in favcount]),
                      date=date,
                      staff=infobox,
                      relations=relations)
