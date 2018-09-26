import logging
from enum import Enum

from dictdiffer import diff
from sqlalchemy import Column, Integer, String, Date
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.ext.declarative import declarative_base

from common.logger import initialize_logger

logger = logging.getLogger(__name__)
initialize_logger(logger)

Base = declarative_base()


class CollectionStatus(Enum):
    untouched = 0
    wish = 1
    wishes = 1
    collect = 2
    collections = 2
    do = 3
    doings = 3
    on_hold = 4
    dropped = 5


class SubjectType(Enum):
    all = -1
    book = 1
    anime = 2
    music = 3
    game = 4
    real = 6


class Record(Base):
    __tablename__ = 'record'

    MAX_NAME_LENGTH = 300
    MAX_TAGS_LENGTH = 300
    MAX_COMMENT_LENGTH = 300  # Bangumi's limit is 200, we relax this constraint to avoid some unexpected situations

    subject_id = Column(Integer, primary_key=True, index=True)  # iid
    user_id = Column(Integer, primary_key=True, index=True)  # uid
    username = Column(String(MAX_NAME_LENGTH), index=True)  # name
    nickname = Column(String(MAX_NAME_LENGTH), index=True)
    subject_type = Column(Integer, nullable=False)  # typ
    collection_status = Column(Integer, nullable=False)  # state
    add_date = Column(Date, nullable=False)  # adddate
    rate = Column(Integer)  # rate
    tags = Column(ARRAY(String))  # tags
    comment = Column(String(MAX_COMMENT_LENGTH))  # comment

    def __repr__(self):
        return "<Record(username=%s, subject_id=%s, subject_type=%s, collection_status=%s)>" % (self.username,
                                                                                                self.subject_id,
                                                                                                self.subject_type,
                                                                                                self.collection_status)

    def __init__(self, record, need_parse=True):
        """
        constructor, record might have been parsed or not, use need_parse to determine
        :param record: record, it might have been parsed or not
        """
        if need_parse:
            parsed_record = self.parse_input(record)
        else:
            parsed_record = record

        self.set_attribute(parsed_record)

    @staticmethod
    def parse_input(raw_record):
        """
        Parse the raw dict into a normalized one
        Some of the attribute has already been parsed by the spider so we don't need to do it again
        i.e. parsing date
        :param raw_record:
        :return: parsed dict
        """
        parsed_record = {'subject_id': raw_record.get('iid'), 'user_id': raw_record.get('uid'),
                         'username': raw_record.get('name'), 'nickname': raw_record.get('nickname'),
                         'subject_type': Record.map_subject_type_str_to_int(raw_record.get('typ')),
                         'collection_status': Record.map_collection_status_str_to_int(raw_record.get('state')),
                         'add_date': raw_record.get('adddate'), 'rate': raw_record.get('rate'),
                         'tags': raw_record.get('tags'),
                         'comment': Record.truncate_str(raw_record.get('comment'), Record.MAX_COMMENT_LENGTH)}

        return parsed_record

    @staticmethod
    def truncate_str(raw_str, max_length):
        """
        truncate string to max_length, or return None if it's not a string
        :param raw_str:  raw string
        :param max_length:  max length
        :return:
        """
        if not isinstance(raw_str, str):
            return None

        stripped_str = raw_str.lstrip()

        return stripped_str[:max_length - 2] + '..' if len(stripped_str) > max_length else stripped_str

    @staticmethod
    def map_subject_type_str_to_int(type_str):
        """
        Map the string subject type to the relevant int value, in order to be consistent with bangumi's API
        :param type_str: raw subject type string
        :return: parsed collection
        """
        if not isinstance(type_str, str):
            return None

        # use anime as the default value
        mapped_int = SubjectType.all.value

        try:
            mapped_int = SubjectType[type_str].value
        except KeyError as keyError:
            logger.warning(keyError)
            logger.warning('Malformed subject type received: %s, assigning the default value: all', type_str)
        return mapped_int

    @staticmethod
    def map_collection_status_str_to_int(collection_status_str):
        """
        Map the map_collection_status_str_to_int to the relevant int value, in order to be consistent with bangumi's API
        :param collection_status_str: raw collection status
        :return: parsed collection
        """
        if not isinstance(collection_status_str, str):
            return None

        # use anime as the default value
        mapped_int = CollectionStatus.untouched.value

        try:
            mapped_int = CollectionStatus[collection_status_str].value
        except KeyError as keyError:
            logger.warning(keyError)
            logger.warning('Malformed collection received: %s, assigning the default value: untouched',
                           collection_status_str)
        return mapped_int

    def set_attribute(self, parsed_subject):
        """
        Set attribute in subject
        :param parsed_subject: normalized, parsed subject
        :return:
        """
        self.subject_id = parsed_subject.get('subject_id')
        self.user_id = parsed_subject.get('user_id')
        self.username = parsed_subject.get('username')
        self.nickname = parsed_subject.get('nickname')
        self.subject_type = parsed_subject.get('subject_type')
        self.collection_status = parsed_subject.get('collection_status')
        self.add_date = parsed_subject.get('add_date')
        self.rate = parsed_subject.get('rate')
        self.tags = parsed_subject.get('tags')
        self.comment = parsed_subject.get('comment')

    def diff_self_with_input(self, record_dict):
        """
        Diff the input dict with current object
        :param record_dict: a dict representation of the subject
        :return: a dictdiffer object
        """
        difference = diff(self.__dict__, record_dict, ignore={'_sa_instance_state'})
        return difference
