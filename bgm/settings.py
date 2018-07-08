# -*- coding: utf-8 -*-

# Scrapy settings for bgm project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'bgmSpider'

SPIDER_MODULES = ['bgm.spiders']
NEWSPIDER_MODULE = 'bgm.spiders'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'bgm (+http://www.yourdomain.com)'
ITEM_PIPELINES = {
    #'bgm.pipelines.UserPipeline': 300,
    #'bgm.pipelines.RecordPipeline': 400,
    #'bgm.pipelines.SubjectPipeline': 500
    'bgm.pipelines.TsvPipeline':300
}
RETRY_TIMES = 10
LOG_LEVEL='INFO'
DUPEFILTER_CLASS='scrapy.dupefilters.BaseDupeFilter'

#DOWNLOADER_MIDDLEWARES = {
#    'scrapy.downloadermiddlewares.redirect.RedirectMiddleware': None
#}

#REDIRECT_ENABLED = True

#LOG_FILE = 'scrapy.log'

MYSQL_HOST = 'localhost'
MYSQL_DBNAME = 'bgm'
MYSQL_USER = 'bgmer'
MYSQL_PASSWD = 'sai'
MYSQL_SOCKET = '/var/run/mysqld/mysqld.sock'

########################################
# The following settings are only applicable to Ronnie Wang's spider setting
# Because Ronnie only uses Azure for storage.
UPLOAD_TO_AZURE_STORAGE = False
AZURE_ACCOUNT_NAME = "ikely"  # this is the subdomain to https://*.blob.core.windows.net/
AZURE_ACCOUNT_KEY = ""
AZURE_CONTAINER = 'bangumi'   # the name of the container (you should have already created it)
########################################