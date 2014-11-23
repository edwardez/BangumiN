from datetime import date
from urlparse import urlparse

class Record:

    def __init__(self, iid, savedate, state, rate = None, comment = None, tags = None):
        self.id = iid
        self.savedate = savedate
        self.state = state

        if not rate:
            self.rate = 0
        else:
            self.rate = rate

        if not comment:
            self.comment = u""
        else:
            self.comment = comment

        if not tags:
            self.tags = []
        else:
            self.tags = tags

def parsedate(bgmdate):
    "2013-1-1 to isostandard"
    return date(int(bgmdate.split('-')[0]), int(bgmdate.split('-')[1]), int(bgmdate.split('-')[2]))

def getnextpage(url):
    tp = url.split("=")
    if len(tp)==2:
        return tp[0]+'='+str(int(tp[1])+1)
    else:
        return tp[0]+'?page=2'
