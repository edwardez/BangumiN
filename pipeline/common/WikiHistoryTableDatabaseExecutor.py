import logging

from common.GeneralDatabaseExecutor import GeneralDatabaseExecutor
from common.logger import initialize_logger

logger = logging.getLogger(__name__)
initialize_logger(logger)


class WikiHistoryTableDatabaseExecutor(GeneralDatabaseExecutor):
    """
    ORM Database executor for record table
    """

    def __init__(self, entity_model, commit_threshold):
        """
        Initialize DatabaseExecutor
        :param entity_model:  Model class
        :param commit_threshold: commit every commit_threshold entities are added to the session, currently not in use
        """
        super().__init__(entity_model, commit_threshold)

    def delete(self, entities_ids, batch_size=500):
        raise Exception("delete is not supported yet")

    def query_user_range(self, min_id, max_id):
        """
        Query table to get data in the specified range
        :param min_id: minimum id
        :param max_id: maximum id
        :return:
        """
        if not isinstance(min_id, int) or not isinstance(max_id,
                                                         int) or min_id >= max_id:
            raise ValueError(
                'min must be smaller than max and both must be int')
        return self.session.query(self.EntityModel) \
            .filter(self.EntityModel.user_id >= min_id) \
            .filter(self.EntityModel.user_id < max_id) \
            .all()
