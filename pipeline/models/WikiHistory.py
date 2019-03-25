import logging
from enum import Enum

from dictdiffer import diff
from sqlalchemy import Column, Integer, String, Date
from sqlalchemy.ext.declarative import declarative_base

from common.logger import initialize_logger

logger = logging.getLogger(__name__)
initialize_logger(logger)

Base = declarative_base()


class EditType(Enum):
    subject = 1
    character = 2
    person = 3
    ep = 4
    subject_relation = 5
    subject_person_relation = 6
    subject_character_relation = 7


class WikiHistory(Base):
    __tablename__ = 'wiki_history'

    MAX_COMMENT_LENGTH = 1000

    id = Column(Integer, autoincrement=True, primary_key=True)
    user_id = Column(Integer, index=True, nullable=True)
    entry_id = Column(Integer, index=True, nullable=True)
    edit_comment = Column(String(MAX_COMMENT_LENGTH), nullable=True)
    edit_time = Column(Date, nullable=True)
    edit_type = Column(Integer, nullable=True)

    def __repr__(self):
        return "<WikiHistory(id=%s,user_id=%s, entry_id=%s, edit_comment=%s, " \
               "edit_time=%s, edit_type=%s)>" % (
                   self.user_id,
                   self.id,
                   self.entry_id,
                   self.edit_comment,
                   self.edit_time,
                   self.edit_type)

    def __init__(self, wiki_history, need_parse=True):
        """
        constructor, wiki history might have been parsed or not, use need_parse to determine
        :param wiki_history: wiki history record, it might have been parsed or not
        """
        if need_parse:
            parsed_wiki_history = self.parse_input(wiki_history)
        else:
            parsed_wiki_history = wiki_history

        self.set_attribute(parsed_wiki_history)

    @staticmethod
    def parse_input(raw_wiki_history):
        """
        Parse the raw dict into a normalized one
        Some of the attribute has already been parsed by the spider so we don't need to do it again
        i.e. parsing date
        :param raw_wiki_history:
        :return: parsed dict
        """
        parsed_wiki_history = {
            'user_id': raw_wiki_history.get('user_id'),
            'entry_id': raw_wiki_history.get('entry_id'),
            'edit_comment': raw_wiki_history.get('edit_comment'),
            'edit_time': raw_wiki_history.get('edit_time'),
            'edit_type': WikiHistory.map_edit_type_str_to_int(
                raw_wiki_history.get('edit_type')),
        }

        return parsed_wiki_history

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

        return stripped_str[:max_length - 2] + '..' if len(
            stripped_str) > max_length else stripped_str

    @staticmethod
    def map_edit_type_str_to_int(type_str):
        """
        Map the string edit type to the relevant int value
        :param type_str: raw edit type string
        :return: parsed collection
        """
        if not isinstance(type_str, str):
            return None

        # use anime as the default value
        mapped_int = EditType.subject.value

        try:
            mapped_int = EditType[type_str].value
        except KeyError as keyError:
            logger.warning(keyError)
            logger.warning(
                'Malformed edit type received: %s, assigning the default value: subject',
                type_str)
        return mapped_int

    def set_attribute(self, parsed_wiki_history):
        """
        Set attribute in wiki history
        :param parsed_wiki_history: normalized, parsed wiki history
        :return:
        """
        self.id = parsed_wiki_history.get('id')
        self.user_id = parsed_wiki_history.get('user_id')
        self.entry_id = parsed_wiki_history.get('entry_id')
        self.edit_comment = parsed_wiki_history.get('edit_comment')
        self.edit_time = parsed_wiki_history.get('edit_time')
        self.edit_type = parsed_wiki_history.get('edit_type')

    def diff_self_with_input(self, wiki_history_dict):
        """
        Diff the input dict with current object
        :param wiki_history_dict: a dict representation of the wki history
        :return: a dictdiffer object
        """
        difference = diff(self.__dict__, wiki_history_dict,
                          ignore={'_sa_instance_state'})
        return difference
