import logging
import os

from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

from common.DataSyncer import DataSyncer
from models.User import User
from models.UserExclude import UserExclude
from record.bgm.spiders.spider import RecordSpider

logger = logging.getLogger(__name__)


class Scraper:
    def __init__(self):
        settings_file_path = 'record.bgm.settings'  # The path seen from root, ie. from main.py
        os.environ.setdefault('SCRAPY_SETTINGS_MODULE', settings_file_path)
        self.process = CrawlerProcess(get_project_settings())
        self.spiders = RecordSpider
        self.dataSyncer = DataSyncer('https://api.bgm.tv/user/', User, 435000, 8)

    def calculate_incremental_scraping_range(self):

        #  get current user with maximum id in database
        current_max_id_user = self.dataSyncer.databaseExecutor.session \
            .query(User) \
            .order_by(User.id.desc()) \
            .first()

        current_user_max_id = current_max_id_user.id \
            if current_max_id_user is not None else 0

        max_db_id = max(1, current_user_max_id)
        max_api_id = max(1, self.dataSyncer.requestHandler.max_id)
        self.dataSyncer.databaseExecutor.close_session()
        return max_db_id, max_api_id

    def get_excluding_list(self):
        """
        Get a list of users that'll be skipped during scraping
        :param db_session:
        :return:
        """
        excluding_list = []
        excluding_users = self.dataSyncer.databaseExecutor.session.query(UserExclude) \
            .all()

        for user in excluding_users:
            excluding_list.append(user.id)

        return excluding_list

    def run_full_sync(self):

        max_api_id = max(1, self.dataSyncer.requestHandler.max_id)
        excluding_list = self.get_excluding_list()

        # noinspection PyTypeChecker
        self.process.crawl(self.spiders, user_id_min=1, user_id_max=max_api_id, excluding_list=excluding_list)
        self.process.start()  # the script will block here until the crawling is finished

    def run_partial_sync(self):
        max_db_id, max_api_id = self.calculate_incremental_scraping_range()
        if max_db_id > max_api_id:
            logger.info(
                'Nothing to sync as there\'s no new user. Current max id in API :%s, max id in database: :%s',
                max_api_id, max_db_id)
            return None

        excluding_list = self.get_excluding_list()

        # noinspection PyTypeChecker
        self.process.crawl(self.spiders, user_id_min=max_db_id, user_id_max=max_api_id, excluding_list=excluding_list)
        self.process.start()  # the script will block here until the crawling is finished
