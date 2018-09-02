import asyncio
import logging

import aiohttp
import backoff

from common.logger import initialize_logger, stream_handler

logger = logging.getLogger(__name__)

logging.getLogger('backoff').addHandler(stream_handler)
initialize_logger(logger)


def on_backoff_give_up(details):
    # logging details on backoff give up
    logger.warning('Backing off {elapsed:0.1f} seconds afters {tries} tries calling function {target} with '
                   'args {args} and kwargs {kwargs}'.format(**details))


class RequestHandler:
    """
    A general-purpose request handler for BangumiN
    """

    def __init__(self, api_url_prefix, base_max_id, max_concurrent_connections=10):
        self.API_URL_PREFIX = api_url_prefix
        self.max_concurrent_connections = max_concurrent_connections
        logger.info('Starting calculating current max id in API.')
        self.find_max_id_base_step = 10000
        self.max_id = self.guess_current_max_id(base_max_id, self.find_max_id_base_step)

    @staticmethod
    def is_existed_entity(subject):
        if not isinstance(subject, dict):
            # if it's not a dict: something is not correct, i.e. network error, we're not sure about when we should stop
            # and since something is not correct, we just raise an exception
            raise ValueError('Subject must be a dict')
        else:
            if subject.get('code') == 404:
                # if the code is 404, subject doesn't exist, returns False
                return False
            return True

    @backoff.on_exception(backoff.expo,
                          (aiohttp.ClientError, asyncio.TimeoutError),
                          jitter=backoff.random_jitter,
                          on_giveup=[on_backoff_give_up],
                          max_tries=2)
    async def fetch(self, session, url):
        """
        Single fetch
        :param session: aiohttp session
        :param url: url object
        :return: response
        """
        async with session.get(url.get('original_url')) as response:
            if response:
                data = await response.json()
                # if response is not an exception and is a valid subject dict
                if isinstance(data, dict) and (data.get('id') or data.get('code') == 404):
                    data['true_id'] = data.get('id') if data.get('id') is not None else url.get('original_id')
                    data['id'] = url.get('original_id')
                return data

    async def fetch_all(self, urls, loop):
        """
        Batch fetch
        :param urls: list of urls dicts
        :param loop: asyncio loop
        :return:
        """
        connector = aiohttp.TCPConnector(limit=self.max_concurrent_connections)
        async with aiohttp.ClientSession(connector=connector, loop=loop) as session:
            result = await asyncio.gather(*[self.fetch(session, url) for url in urls],
                                          return_exceptions=True)
            return result

    def generate_url_from_ids(self, ids):
        """
        Generate url from a list or set of ids, [PREFIX/ID1, PREFIX/ID2...]
        :param ids: list or set of ids
        :return: generated urls dict
        """
        if not isinstance(ids, list) and not isinstance(ids, set):
            raise TypeError('subject_ids must be a list or set of int subject id')
        urls = []
        for original_id in ids:
            if not isinstance(original_id, int):
                raise TypeError('Each subject_id must be an integer')
            urls.append({'original_url': self.API_URL_PREFIX + str(original_id), 'original_id': original_id})
        return urls

    def generate_url_from_range(self, min_id, max_id):
        """
        Generate a consecutive list of urls dict
        :param min_id: minimum id
        :param max_id: maximum id
        :return: generated urls dict
        """
        if min_id > max_id:
            raise ValueError('min_id must be smaller than max_id')
        urls = []
        for i in range(min_id, max_id):
            urls.append({'original_url': self.API_URL_PREFIX + str(i), 'original_id': i})
        return urls

    def are_all_responses_not_found(self, ids):
        """
        Accept a list or set of ids, check whether all of them don't exist
        :param ids: a list or set of ids
        :return: True if all of them don't exist, else False
        """
        responses = self.run_with_urls(self.generate_url_from_ids(ids))
        are_all_responses_not_found = True
        for response in responses:
            entity_exists = self.is_existed_entity(response)
            # if a existed entity is found, return immediately
            if entity_exists:
                return False
        return are_all_responses_not_found

    def guess_current_max_id(self, base_id, step=10000):
        """
        Guess current max id by using a binary search
        This function utilizes the response of bangumi API: all consecutive ids will return a valid result,
        once a id that's bigger than maximum id is queried, a json with status 200 and {code: 404} will be returned
        Be warned! if Bangumi's subject id becomes obviously larger than the initial base_id, a StackOverflow might be
        raised, use it at your own risk
        TODO: refactor this function
        :param base_id: where the search should start from
        :param step: each of the time, we should step forward or step back this number of ids
        :return: current maximum id
        """
        start_id = base_id
        end_id = max(base_id + step, base_id + 1)
        responses = self.run_with_urls(self.generate_url_from_ids([start_id, end_id]))
        start_id_exists = self.is_existed_entity(responses[0])
        end_id_exists = self.is_existed_entity(responses[1])
        logger.debug('%s exists: %s', start_id, start_id_exists)
        logger.debug('%s exists: %s', end_id, end_id_exists)
        if start_id_exists and end_id_exists:
            # even end_id exists, we increase start_id with the number of step
            return self.guess_current_max_id(start_id + max(step // 2, 1), step)
        elif not end_id_exists:
            if start_id_exists and end_id - start_id <= 1:
                # Bangumi's id response is not consecutive, i.e. 1/2/4 might exist, while 3 might not
                # however this is a rare case and we don't want to examine lots of subject id every time
                # so we do a trick here: only checking whether start_id and end_id exist, if start_id exists
                # while end doesn't in the same time, some of the 'future' id after end_id exists, we might have
                # accidentally fall into such
                # cases, we check whether some ids after the purposed end_id exists
                if not self.are_all_responses_not_found(
                        [end_id, end_id + 10, end_id + 10 * 2, end_id + 10 * 3, end_id + 10 * 4]):
                    return self.guess_current_max_id(start_id, start_id + self.find_max_id_base_step)
                else:
                    # eureka! return the current max subject id
                    logger.info('Heuristic search found current max id is ' + str(start_id))
                    return start_id
            else:
                # else end_id doesn't exist, start_id may or may not: we don't really care
                # just decrease the base id with the number of step
                return self.guess_current_max_id(start_id - max(step // 2, 1), step // 2)

    def run_with_urls(self, urls):
        """
        Request through API with a specified list of urls
        :param urls: list of urls to retrieve
        :return: response
        """
        if not isinstance(urls, list) or len(urls) < 1:
            raise ValueError('urls should be a list of url strings')

        loop = asyncio.get_event_loop()
        response = loop.run_until_complete(self.fetch_all(urls, loop))

        return response
