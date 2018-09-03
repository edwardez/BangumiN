import logging

from common.DataSyncer import DataSyncer
from common.logger import initialize_logger
from models.User import User

logger = logging.getLogger(__name__)
initialize_logger(logger)


class UserPartialSyncer:
    """
    Sync only latest users info from API to db
    """

    def __init__(self):
        self.dataSyncer = DataSyncer('https://api.bgm.tv/user/', User, 435000, 9)

    def calculate_incremental_scraping_range(self):
        #  get current user with maximum id in database
        current_max_id_user = self.dataSyncer.databaseExecutor.session \
            .query(User) \
            .order_by(User.id.desc()) \
            .first()

        current_user_max_id = current_max_id_user.id \
            if current_max_id_user is not None else 0

        return max(1, current_user_max_id), self.dataSyncer.requestHandler.max_id

    def run(self):
        max_db_id, max_api_id = self.calculate_incremental_scraping_range()

        if max_db_id < max_api_id:
            logger.info(
                'Current max user id:%s in database is smaller than max id:%s in API, starting syncing data from'
                ' %s to %s', max_db_id, max_api_id, max_db_id, max_api_id)
            self.dataSyncer.start_scraper(max_db_id, max_api_id + 1)
        else:
            logger.info(
                'Nothing to sync as there\'s no new user. Current max id in API :%s, max id in database: :%s',
                max_api_id, max_db_id)


if __name__ == "__main__":
    userPartialSyncer = UserPartialSyncer()
    userPartialSyncer.run()
