# -*- coding: utf-8 -*-

import datetime
import re

ptn = re.compile(r"""(((1\d{3})|(20\d{2}))([./\-\\]|年)( #
                     (((0?[13578])|(1[0-2]))(月|[./\-\\])(([1-2][0-9])|(3[01])|(0?[1-9])))日?| #
                     (((0?[469])|(11))(月|[./\-\\])(([1-2][0-9])|(30)|(0?[1-9])))日?| #
                     (0?2(月|[./\-\\])(([1-2][0-9])|(0?[1-9])))日? #
                    ))| #
                    (((1\d{3})|(20\d{2}))([./\-\\]|年)(1[0-2]|0?[1-9])月?)| #
                    (((1\d{3})|(20\d{2}))([./\-\\]|年)?)""", re.X)
blockstr = '[\u5df2\u5c01\u7981]'
datestr = ['放送开始', '上映年度', '上映日期', '上映时间', '发行日期', '开始',
           '发售日', '发售日期', '发行时间', '连载期间']
statestr = ['wishes', 'collections', 'doings', 'on_hold', 'dropped']
featurelist = [['キャラクターデザイン', '人物设定', '人设'],
               ['机械设定', 'メカニックデザイン'],
               ['动画制作', 'アニメーション制作', '動畫製作'],
               ['美术监督', '美術監督'],
               ['美術', '美术', '美術設定', '背景', '背景美术'],
               ['総監督', '总监督', '监督', '監督'],
               ['分镜'],
               ['脚本', '剧本', '编剧', '劇本'],
               ['原作', '原案', '原案など'],
               ['动画制作', '制作', '製作', 'プロデューサー', '制作公司', '出品公司'],
               ['总作画监督', '作画监督', '作画監督'],
               ['原画'],
               ['演出'],
               ['系列构成', 'シリーズ構成'],
               ['导演', '总导演', '導演'],
               ['音响监督', '音響監督'],
               ['音乐制作', '音乐', '音楽', '音樂', '音乐制作人'],
               ['摄影监督', '撮影監督'],
               ['色彩设计', '色彩設計', '色彩设定', '色指定'],
               ['人物原案', '角色原案', 'キャラクター原案'],
               ['企画', '企划'],
               ['主题歌编曲'],
               ['主题歌作曲'],
               ['主题歌演出'],
               # books
               ['作者', '著者'],
               ['作画', '作畫'],
               ['插画', 'イラスト', '插图'],
               ['出版社', '其他出版社'],
               ['连载杂志', '連載雜誌'],
               # musics
               ['艺术家', '表演者', 'artist'],
               ['Vocals', '艺术家(Vocal)', 'Vocal', 'vocal', '艺术家 (Vocal)'],
               ['艺术家(Remixer)', 'Remix', 'VOCAL', 'Remixer'],
               ['作曲', '作曲家', '作詞・作曲・編曲', '作編曲', 'composer', '作曲/编曲',
                'Composition', '作编曲', 'Composer', '作詞・作曲', 'Composers', 'Compose'],
               ['作词', 'lyrics', '作詞', '作詞・作曲・編曲', 'lyric', 'Lyricist',
                '作詞・作曲', '歌詞', 'Lyrics', 'Lyric'],
               ['编曲', '編曲', '作詞・作曲・編曲', '作編曲', '作曲/编曲', '作编曲'],
               ['发行商', '出版者', '唱片公司', '出版商'],
               ['厂牌'],
               ['Illustration & Design', 'Designer', 'Design & Artwork', 'jacket', 'design',
                'Graphic Design', 'デザイン', 'Illustrations', 'Design Works', 'イラスト',
                'Illustrator', 'Illustlation', 'Jacket Illust & Design', 'Jacket Illust',
                'ILLUSTRATOR', 'Illust', 'Design', 'Jacket Illustration', 'illust',
                'illustration', 'Illustration'],
               # games
               ['开发', '游戏开发', '制作团队', '游戏制作商', '制作厂商', '开发厂商', '开发者',
                '开发公司', '游戏厂商', '制作社团', '开发商'],
               ['游戏出版商', '发行', '发行厂商', '游戏发行', '制作发行', '发行公司'],
               ['遊戲設計師', '设计师', '游戏设计师']
               # real
               # not implemented yet.
               ]
relationlist = ['前传', '原声集', '续集', '资料片、外传', '印象曲', '系列', '游戏',
                '三次元', '片尾曲', '不同版本', '画集', '插入歌', '衍生', '番外篇', '不同演绎',
                '动画', '主线故事', '角色歌', '单行本', '总集篇', '片头曲', '广播剧', '不同世界观',
                '相同世界观', '角色出演', '其他', '全集', '书籍', '单行本']


def getnextpage(url):
    tp = url.split("=")
    if len(tp) == 2:
        return tp[0] + '=' + str(int(tp[1]) + 1)
    else:
        return tp[0] + '?page=2'


def parsedate(bgmdate):
    mt = ptn.search(bgmdate)
    if mt.groups()[0] is not None:  # year, month and date are all matched.
        year = int(mt.groups()[1])
        if mt.groups()[6] is not None:  # 1,3,5,...
            month = int(mt.groups()[7])
            days = int(mt.groups()[11])
        elif mt.groups()[15] is not None:  # 4,6,...
            month = int(mt.groups()[16])
            days = int(mt.groups()[20])
        else:
            month = 2
            days = int(mt.groups()[26])
        dt = datetime.date(year, month, days)
    elif mt.groups()[29] is not None:
        year = int(mt.groups()[30])
        month = int(mt.groups()[34])
        dt = datetime.date(year, month, 1)
    elif mt.groups()[35] is not None:
        year = int(mt.groups()[36])
        dt = datetime.date(year, 1, 1)
    else:
        return None
    return dt
