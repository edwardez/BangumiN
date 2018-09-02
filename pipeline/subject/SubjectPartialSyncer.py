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
        self.dataSyncer = DataSyncer('https://api.bgm.tv/subject/', Subject, 258000, 8)

    def run(self):
        #  get current subject with maximum id in database
        current_subject_with_max_id = self.dataSyncer.databaseExecutor.session \
            .query(Subject) \
            .order_by(Subject.id.desc()) \
            .first()

        current_subject_with_max_id = current_subject_with_max_id \
            if current_subject_with_max_id is not None else {'id': 0}

        max_id_api = max(1, self.dataSyncer.requestHandler.max_id)
        max_id_db = max(1, current_subject_with_max_id.id)

        if max_id_db < max_id_api:
            logger.info(
                'Current max subject id:%s in database is smaller than max id:%s in API, start syncing data from'
                ' %s to %s', max_id_db, max_id_api, max_id_db, max_id_api)
            self.dataSyncer.start_scraper(current_subject_with_max_id.id, self.dataSyncer.requestHandler.max_id)
        else:
            logger.info(
                'Nothing to sync as there\'s no new subject. Current max id in API :%s, max id in database: :%s',
                max_id_api, max_id_db)


if __name__ == "__main__":
    subjectPartialSyncer = SubjectPartialSyncer()
    subjectPartialSyncer.run()
