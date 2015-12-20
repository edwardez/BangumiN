# -*- coding: utf-8 -*-

from urlparse import urlparse
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
[u'美術',u'美术',u'美術設定',u'背景',u'背景美术'],
[u'総監督',u'总监督',u'监督',u'監督'],
[u'分镜'],
[u'脚本',u'剧本',u'编剧',u'劇本'],
[u'原作',u'原案',u'原案など'],
[u'动画制作',u'制作',u'製作',u'プロデューサー',u'制作公司',u'出品公司'],
[u'总作画监督',u'作画监督',u'作画監督'],
[u'原画'],
[u'演出'],
[u'系列构成',u'シリーズ構成'],
[u'导演',u'总导演',u'導演'],
[u'音响监督',u'音響監督'],
[u'音乐制作',u'音乐',u'音楽',u'音樂',u'音乐制作人'],
[u'摄影监督',u'撮影監督'],
[u'色彩设计',u'色彩設計',u'色彩设定',u'色指定'],
[u'人物原案',u'角色原案',u'キャラクター原案'],
[u'企画',u'企划'],
[u'主题歌编曲'],
[u'主题歌作曲'],
[u'主题歌演出'],
#books
[u'作者',u'著者'],
[u'作画',u'作畫'],
[u'插画',u'イラスト',u'插图'],
[u'出版社',u'其他出版社'],
[u'连载杂志',u'連載雜誌'],
#musics
[u'艺术家',u'表演者',u'artist'],
[u'Vocals',u'艺术家(Vocal)',u'Vocal',u'vocal',u'艺术家 (Vocal)'],
[u'艺术家(Remixer)',u'Remix',u'VOCAL',u'Remixer'],
[u'作曲',u'作曲家',u'作詞・作曲・編曲',u'作編曲',u'composer',u'作曲/编曲',
u'Composition',u'作编曲',u'Composer',u'作詞・作曲',u'Composers',u'Compose'],
[u'作词',u'lyrics',u'作詞',u'作詞・作曲・編曲',u'lyric',u'Lyricist',
u'作詞・作曲',u'歌詞',u'Lyrics',u'Lyric'],
[u'编曲',u'編曲',u'作詞・作曲・編曲',u'作編曲',u'作曲/编曲',u'作编曲'],
[u'发行商',u'出版者',u'唱片公司',u'出版商'],
[u'厂牌'],
[u'Illustration & Design',u'Designer',u'Design & Artwork',u'jacket',u'design',
u'Graphic Design',u'デザイン',u'Illustrations',u'Design Works',u'イラスト',
u'Illustrator',u'Illustlation',u'Jacket Illust & Design',u'Jacket Illust',
u'ILLUSTRATOR',u'Illust',u'Design',u'Jacket Illustration',u'illust',
u'illustration',u'Illustration'],
#games
[u'开发',u'游戏开发',u'制作团队',u'游戏制作商',u'制作厂商',u'开发厂商',u'开发者',
u'开发公司',u'游戏厂商',u'制作社团',u'开发商'],
[u'游戏出版商',u'发行',u'发行厂商',u'游戏发行',u'制作发行',u'发行公司'],
[u'遊戲設計師',u'设计师',u'游戏设计师']
#real
#not implemented yet.
]
relationlist = [u'前传',u'原声集',u'续集',u'资料片、外传',u'印象曲',u'系列',u'游戏',
u'三次元',u'片尾曲',u'不同版本',u'画集',u'插入歌',u'衍生',u'番外篇',u'不同演绎',
u'动画',u'主线故事',u'角色歌',u'单行本',u'总集篇',u'片头曲',u'广播剧',u'不同世界观',
u'相同世界观',u'角色出演',u'其他',u'全集',u'书籍',u'单行本']

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
            month = 2
            days = int(mt.groups()[27])
        dt = datetime.datetime(year, month, days)
    elif mt.groups()[29] is not None:
        year = int(mt.groups()[30])
        month = int(mt.groups()[34])
        dt = datetime.datetime(year, month, 1)
    elif mt.groups()[35] is not None:
        year = int(mt.groups()[36])
        dt = datetime.datetime(year,1,1,1)
    else: return None
    return dt
