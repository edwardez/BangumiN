import logging

from sqlalchemy.sql.elements import Tuple

from common.GeneralDatabaseExecutor import GeneralDatabaseExecutor
from common.logger import initialize_logger
from models.Record import Record

logger = logging.getLogger(__name__)
initialize_logger(logger)


class RecordTableDatabaseExecutor(GeneralDatabaseExecutor):
    """
    ORM Database executor for record table
    """

    def __init__(self, entity_model, commit_threshold):
        """
        Initialize DatabaseExecutor
        :param entity_model:  Model class
        :param commit_threshold: commit every commit_threshold entities are added to the session, currently not in use
        """
        super().__init__(Record, commit_threshold)

    def delete(self, entities_ids):
        """
        Delete entities according to the entities_ids set/list
        :param entities_ids: Expect to be a list/set of entities_ids that'll be delete, i.e. ((1,2), (1,3))
        :return: number of deleted
        """
        deleted_entities = 0

        try:
            self.session.query(self.EntityModel) \
                .filter(Tuple(self.EntityModel.user_id, self.EntityModel.subject_id).in_(entities_ids)) \
                .delete(synchronize_session='fetch')
            self.session.commit()
            deleted_entities = len(entities_ids)
        except Exception as exception:
            self.session.rollback()
            logger.error('Skipping due to unhandled exception')
            logger.error(exception)
        return deleted_entities

    def query_range(self, min_id, max_id):
        """
        Query table to get data in the specified range
        :param min_id: minimum id
        :param max_id: maximum id
        :return:
        """
        if not isinstance(min_id, int) or not isinstance(max_id, int) or min_id >= max_id:
            raise ValueError('min must be smaller than max and both must be int')

        result = None
        try:
            result = self.session.query(self.EntityModel) \
                .filter(self.EntityModel.user_id >= min_id) \
                .filter(self.EntityModel.user_id < max_id) \
                .all()
        except Exception as exception:
            logger.error('Unhandled Exception during querying the database')
            logger.error(exception)
            self.session.rollback()

        return result
