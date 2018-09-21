import logging

from common.DataSyncer import DataSyncer
from common.logger import initialize_logger
from models.Subject import Subject

logger = logging.getLogger(__name__)
initialize_logger(logger)


class SubjectPartialSyncer:
    """
    Sync only latest subjects info from API to db
    """

    def __init__(self):
        self.dataSyncer = DataSyncer('https://api.bgm.tv/subject/', Subject, 259000, 9, '?responseGroup=medium')

    def run(self):
        #  get current subject with maximum id in database
        current_max_id_subject = self.dataSyncer.databaseExecutor.session \
            .query(Subject) \
            .order_by(Subject.id.desc()) \
            .first()

        current_subject_max_id = current_max_id_subject.id \
            if current_max_id_subject is not None else 0

        max_api_id = self.dataSyncer.requestHandler.max_id
        max_db_id = max(1, current_subject_max_id)

        if max_db_id < max_api_id:
            logger.info(
                'Current max subject id:%s in database is smaller than max id:%s in API, starting syncing data in'
                ' %s to %s', max_db_id, max_api_id, max_db_id, max_api_id)
            self.dataSyncer.start_scraper(max_db_id, max_api_id + 1)
        else:
            logger.info(
                'Nothing to sync as there\'s no new subject. Current max id in API :%s, max id in database: :%s',
                max_api_id, max_db_id)


if __name__ == "__main__":
    subjectPartialSyncer = SubjectPartialSyncer()
    subjectPartialSyncer.run()
