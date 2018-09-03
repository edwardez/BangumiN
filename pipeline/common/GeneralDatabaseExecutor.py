import logging
import os

from sqlalchemy import create_engine
from sqlalchemy.exc import ProgrammingError
from sqlalchemy.orm import sessionmaker

from common.logger import initialize_logger

logger = logging.getLogger(__name__)
initialize_logger(logger)


class GeneralDatabaseExecutor:
    """
    ORM Database executor, this class assumes the primary key of the model is id
    """

    def __init__(self, entity_model, commit_threshold):
        """
        Initialize DatabaseExecutor
        :param entity_model:  Model class
        :param commit_threshold: commit every commit_threshold entities are added to the session, currently not in use
        """
        self.EntityModel = entity_model
        self.engine = create_engine(
            self.construct_db_uri(), use_batch_mode=True)
        self.session = sessionmaker(bind=self.engine)()
        self.commit_threshold = commit_threshold

    @staticmethod
    def construct_db_uri():
        """
        construct db uri, raise error if some value is not set in environment
        :return: constructed db uri
        """
        username = os.getenv('DB_USERNAME')
        password = os.getenv('DB_PASSWORD')
        url = os.getenv('DB_URL')
        port = os.getenv('DB_PORT')
        if username is None or password is None or url is None or port is None:
            raise ValueError('Database username/password/url/port is not set!')
        return 'postgresql+psycopg2://' + username + ':' + password + '@' + url + ':' + port + '/bangumi'

    def close_session(self):
        self.session.close()

    def create(self, entities):
        """
        Create new entities in database
        :param entities: list of entities
        :return:
        """
        created_entities = 0
        try:
            self.session.bulk_save_objects(entities)
            self.session.commit()
            created_entities = len(entities)
        except ProgrammingError as programmingError:
            self.session.rollback()
            logger.error(programmingError)
            logger.error('Skipping due to programmingError')
        except Exception as exception:
            self.session.rollback()
            logger.error('Skipping due to unhandled exception')
            logger.error(exception)

        return created_entities

    def update(self, entities):
        """
        Update entities according to data in entity list
        Currently there's no diff and all data in database will be overwritten
        :param entities: list of entities
        :return:
        """
        updated_entities = 0
        try:
            self.session.add_all(entities)
            updated_entities = len(entities)
        except ProgrammingError as programmingError:
            self.session.rollback()
            logger.error(programmingError)
            logger.error('Skipping due to programmingError')
        except Exception as exception:
            self.session.rollback()
            logger.error('Skipping due to unhandled exception')
            logger.error(exception)

        return updated_entities

    def delete(self, entities_ids):
        """
        Delete entities according to the entities_ids set/list
        :param entities_ids: Expect to be a list/set of entities_ids that'll be delete
        :return: number of deleted
        """
        deleted_entities = 0
        try:
            self.session.query(self.EntityModel) \
                .filter(self.EntityModel.id.in_(entities_ids)) \
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
        return self.session.query(self.EntityModel) \
            .filter(self.EntityModel.id >= min_id) \
            .filter(self.EntityModel.id < max_id) \
            .all()
