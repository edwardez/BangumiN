import logging

from common.GeneralDatabaseExecutor import GeneralDatabaseExecutor
from common.RequestHandler import RequestHandler
from common.logger import initialize_logger

logger = logging.getLogger(__name__)
initialize_logger(logger)


class DataSyncer:
    """
    Scrape Bangumi info through API and save in the rds
    """

    def __init__(self, api_url_prefix, database_model_class, base_max_id, max_concurrent_connections=8):
        """

        :param api_url_prefix:
        :param database_model_class: db model class, i.e. Subject, User
        :param base_max_id:
        :param max_concurrent_connections:
        """
        self.max_concurrent_connections = max_concurrent_connections
        self.scrape_step = 1000
        self.databaseModel = database_model_class
        self.databaseExecutor = GeneralDatabaseExecutor(self.databaseModel, self.scrape_step)

        self.requestHandler = RequestHandler(api_url_prefix, base_max_id,
                                             self.max_concurrent_connections)
        #  failed_to_get_entities, i.e. an exception was returned, which indicates we failed to get response
        self.stats = {
            'created_entities': 0,
            'updated_entities': 0,
            'skipped_entities': 0,
            'deleted_entities': 0,
            'failed_to_update_entities': 0,
        }

    @staticmethod
    def entity_exists(response):
        """
        Determine if entity with specified id exists or not according to the response
        :param response: API response
        :return: True if exists, else False
        """
        return response.get('code') != 404 and response.get('error') != 'not found'

    def sync_with_range(self, start_id, end_id):
        """
        Sync data from API to db by scraping API in the consecutive range (start_id, end_id) then write into database
        Create: if entity exists in API but not in db
        Update: if entity exists both in API and db
        Delete: if entity exists in db but not in API
        :param start_id: start id
        :param end_id: end id
        :return: None
        """
        logger.info('Starting scraping in range (%s, %s)', start_id, end_id)
        database_response_dict = {}

        api_responses = self.requestHandler.run_with_urls(self.requestHandler.generate_url_from_range(start_id, end_id))
        logger.debug('API responses are %s', api_responses)
        database_response_entities = self.databaseExecutor.query_range(start_id, end_id)

        for db_entity in database_response_entities:
            database_response_dict[db_entity.id] = db_entity

        # entities_to_create and entities_to_update contain list of entities
        # for deleting and skipping, only id is needed so it's a set
        entities_to_create = []
        entities_to_update = []
        entities_to_delete = set()
        entities_to_skip = set()

        for api_response in api_responses:
            # simple precondition to verify response is valid
            if isinstance(api_response, dict) and api_response.get('id'):
                if api_response.get('id') in database_response_dict.keys():
                    entity = database_response_dict.get(api_response.get('id'))
                    if self.entity_exists(api_response):
                        parsed_api_response = entity.parse_input(api_response)
                        difference = entity.diff_self_with_input(parsed_api_response)
                        if len(list(difference)) > 0:
                            # db/API contain entity and it has difference, overwriting data in db
                            entity.set_attribute(parsed_api_response)
                            entities_to_update.append(entity)
                        else:
                            # db/API contain entity but nothing changes, skipping it
                            entities_to_skip.add(entity.id)


                    else:
                        # db contains entity, API doesn't, delete it from database
                        entities_to_delete.add(entity.id)
                else:
                    if self.entity_exists(api_response):
                        # db doesn't contain entity, API does, create it in db
                        entity = self.databaseModel(api_response)
                        entities_to_create.append(entity)

        logger.info('Creating %s new instances in range (%s, %s)', len(entities_to_create), start_id, end_id)
        created_entities = self.databaseExecutor.create(entities_to_create)
        self.stats['created_entities'] += created_entities

        skipped_entities = len(entities_to_skip)
        self.stats['skipped_entities'] += skipped_entities
        logger.info('Skipping %s existed instances in range (%s, %s) as there\'s no difference', len(entities_to_skip),
                    start_id, end_id)

        logger.info('Updating %s existed instances in range (%s, %s)', len(entities_to_update), start_id, end_id)
        updated_entities = self.databaseExecutor.update(entities_to_update)
        self.stats['updated_entities'] += updated_entities

        logger.info('Deleting %s existed instances in range (%s, %s)', len(entities_to_delete), start_id, end_id)
        deleted_entities = self.databaseExecutor.delete(entities_to_delete)
        self.stats['deleted_entities'] += deleted_entities

        self.stats['failed_to_update_entities'] += \
            end_id - start_id - deleted_entities - updated_entities - created_entities - skipped_entities

    def start_scraper(self, start_id, end_id=None):
        """
        Start scraping with the specified range, commit into database evert number of self.scrape_step requests are made
        if end_id is not specified then it's the calculated max id in API
        :param start_id: (int) start id
        :param end_id: (int) end id
        :return: None
        """
        if end_id is None:
            end_id = self.requestHandler.max_id
        if start_id > end_id:
            raise ValueError('start_id' + str(start_id) + ' is larger than end_id' + str(end_id))

        for current_base_id in range(start_id, end_id, self.scrape_step):
            self.sync_with_range(current_base_id, min(end_id, current_base_id + self.scrape_step))

        logger.info('Finished scraping, affected rows stats: %s', self.stats)
        logger.info(
            'Note: the stats might not reflect the final database state, i.e. if db is manipulated by another session '
            'at the same time.')
        self.databaseExecutor.session.close()


if __name__ == "__main__":
    logger.error('This class shouldn\'t be called directly')
