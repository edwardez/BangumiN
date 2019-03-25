import argparse
import logging

from common.logger import initialize_logger
from subject.SubjectFullSyncer import SubjectFullSyncer
from subject.SubjectPartialSyncer import SubjectPartialSyncer
from user.UserFullSyncer import UserFullSyncer
from user.UserPartialSyncer import UserPartialSyncer

logger = logging.getLogger(__name__)
initialize_logger(logger)
from record.run_scraper import Scraper

#
# scraper = Scraper()
# scraper.run_spiders()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Running pipeline tasks')
    parser.add_argument('task_type',
                        help='type of the task, can be: subject/record/user')
    parser.add_argument('sync_type',
                        help='type of the sync, can be: full/incremental, incremental will only sync latest changes')
    args = parser.parse_args()

    if args.task_type == 'subject' and args.sync_type == 'full':
        subjectFullSyncer = SubjectFullSyncer()
        subjectFullSyncer.run()
    elif args.task_type == 'subject' and args.sync_type == 'incremental':
        subjectPartialSyncer = SubjectPartialSyncer()
        subjectPartialSyncer.run()
    elif args.task_type == 'user' and args.sync_type == 'full':
        userFullSyncer = UserFullSyncer()
        userFullSyncer.run()
    elif args.task_type == 'user' and args.sync_type == 'incremental':
        userPartialSyncer = UserPartialSyncer()
        userPartialSyncer.run()
    elif args.task_type == 'record' and args.sync_type == 'full':
        scraper = Scraper()
        scraper.run_full_sync()
    elif args.task_type == 'record' and args.sync_type == 'incremental':
        scraper = Scraper()
        scraper.run_partial_sync()
    elif args.task_type == 'wiki' and args.sync_type == 'full':
        scraper = Scraper()
        scraper.run_full_sync_wiki()
    else:
        logger.error('Unknown arguments, task_type: %s, sync_type: %s', args.task_type, args.sync_type)
