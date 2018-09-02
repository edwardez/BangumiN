import logging

from common.DataSyncer import DataSyncer
from common.logger import initialize_logger
from models.Subject import Subject

logger = logging.getLogger(__name__)
initialize_logger(logger)


class SubjectFullSyncer:
    """
    Sync subject info from the first one to the latest one
    """

    def __init__(self):
        self.dataSyncer = DataSyncer('https://api.bgm.tv/subject/', Subject, 258000, 9)

    def run(self):
        logger.info('Starting a full sync from API to database in range(%s, %s)', 1,
                    self.dataSyncer.requestHandler.max_id)
        self.dataSyncer.start_scraper(1, self.dataSyncer.requestHandler.max_id)


if __name__ == "__main__":
    subjectFullSyncer = SubjectFullSyncer()
    subjectFullSyncer.run()
