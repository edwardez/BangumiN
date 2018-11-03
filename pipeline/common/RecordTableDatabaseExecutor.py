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

    def delete(self, entities_ids, batch_size=500):
        """
        Delete entities according to the entities_ids set/list
        :param entities_ids: Expect to be a list/set of entities_ids that'll be delete, i.e. ((1,2), (1,3))
        :param batch_size: Number of records to delete in batch
        :return: number of deleted
        """
        deleted_entities = 0
        entities_ids_list = list(entities_ids)
        num_of_iteration = len(entities_ids_list) // batch_size + 1
        for i in range(num_of_iteration):
            logger.info('Starting deleting iteration number %s', i)
            batch_ids = entities_ids_list[i * batch_size:(i + 1) * batch_size]
            try:
                self.session.query(self.EntityModel) \
                    .filter(Tuple(self.EntityModel.user_id, self.EntityModel.subject_id).in_(batch_ids)) \
                    .delete(synchronize_session='fetch')
                self.session.commit()
                deleted_entities += len(batch_ids)
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
