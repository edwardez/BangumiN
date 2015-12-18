# -*- coding: utf-8 -*-

from urlparse import urlparse
import dateutil.parser as parser
import re
import datetime

ptn=re.compile(ur"""(((1\d{3})|(20\d{2}))([./\-\\]|年)( #
                     (((0?[13578])|(1[0-2]))(月|[./\-\\])(([1-2][0-9])|(3[01])|(0?[1-9])))日?| #
                     (((0?[469])|(11))(月|[./\-\\])(([1-2][0-9])|(30)|(0?[1-9])))日?| #
                     (0?2(月|[./\-\\])(([1-2][0-9])|(0?[1-9])))日? #
                    ))| #
                    (((1\d{3})|(20\d{2}))([./\-\\]|年)(1[0-2]|0?[1-9])月?)| #
                    (((1\d{3})|(20\d{2}))([./\-\\]|年)?)""", re.X)
blockstr = u'[\u5df2\u5c01\u7981]';
datestr = [u'放送开始',u'上映年度',u'上映日期',u'上映时间',u'发行日期',u'开始',
u'发售日',u'发售日期',u'发行时间',u'连载期间'];
statestr = [u'wishes', u'collections', u'doings', u'on_hold', u'dropped'];
featurelist = [[u'キャラクターデザイン',u'人物设定',u'人设'],
[u'机械设定',u'メカニックデザイン'],
[u'动画制作',u'アニメーション制作',u'動畫製作'],
[u'美术监督',u'美術監督'],
[u'美術',u'美术',u'美術設定',u'背景',u'背景美术']
[u'総監督',u'总监督',u'监督',u'監督'],
[u'分镜'],
[u'脚本',u'原作',u'剧本'],
[u'动画制作',u'制作',u'製作',u'プロデューサー',u'制作公司',u'出品公司'],
[u'总作画监督',u'作画监督',u'作画監督'],
[u'原画'],
[u'演出'],
[u'系列构成',u'シリーズ構成'],
[u'导演',u'总导演',u'導演']
[u'音响监督',u'音響監督'],
[u'音乐制作',u'音乐',u'音楽',u'音樂',u'音乐制作人'],
[u'摄影监督',u'撮影監督'],
[u'编剧'],
[u'色彩设计',u'色彩設計',u'色彩设定',u'色指定'],
[u'角色原案',u'原案'],
[u'企画',u'企划']
]

def getnextpage(url):
    tp = url.split("=")
    if len(tp)==2:
        return tp[0]+'='+str(int(tp[1])+1)
    else:
        return tp[0]+'?page=2'

def parsedate(bgmdate):
    mt = ptn.search(bgmdate)
    if mt.groups()[0] is not None: # year, month and date are all matched.
        year = int(mt.groups()[1])
        if mt.groups()[6] is not None: # 1,3,5,...
            month = int(mt.groups()[7])
            days = int(mt.groups()[11])
        elif mt.groups()[15] is not None: # 4,6,...
            month = int(mt.groups()[16])
            days = int(mt.groups()[20])
        else:
            month = int(mt.groups()[25]) # 2
            days = int(mt.groups()[27])
        dt = datetime.datetime(year, month, days)
    elif mt.groups()[29] is not None:
        year = int(mt.groups()[30])
        month = int(mt.groups()[34])
        dt = datetime.datetime(year, month, 1)
    elif mt.groups()[35] is not None:
        year = int(mt.groups()[36])
        dt = datetime.datetime(year,1,1)
    else: return None
    return dt
