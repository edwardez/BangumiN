from datetime import date
from urlparse import urlparse

def parsedate(bgmdate):
    "2013-1-1 to isostandard"
    return date(int(bgmdate.split('-')[0]), int(bgmdate.split('-')[1]), int(bgmdate.split('-')[2])).isoformat()

def getnextpage(url):
    tp = url.split("=")
    if len(tp)==2:
        return tp[0]+'='+str(int(tp[1])+1)
    else:
        return tp[0]+'?page=2'
