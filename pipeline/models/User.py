from dictdiffer import diff
from sqlalchemy import Column, Integer, String
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class User(Base):
    __tablename__ = 'user'

    MAX_NAME_LENGTH = 100
    MAX_SIGN_LENGTH = 200
    MAX_URL_LENGTH = 200

    id = Column('id', Integer, primary_key=True)
    username = Column(String(MAX_NAME_LENGTH))
    nickname = Column(String(MAX_NAME_LENGTH))
    url = Column(String(MAX_URL_LENGTH))
    avatar = Column(JSONB)
    sign = Column(String(MAX_SIGN_LENGTH))
    user_group = Column(Integer)

    def __init__(self, user):
        parsed_user = self.parse_input(user)
        self.set_attribute(parsed_user)

    def __repr__(self):
        return '<User(id = %s, username = %s)>' % (self.id, self.username)

    def update(self, user):
        self.parse_input(user)

    @staticmethod
    def parse_input(user):
        """
        parse the raw dict into a normalized one
        :param user: raw user
        :return: parsed dict
        """
        parsed_user = {'id': user.get('id'), 'username': User.truncate_str(user.get('username'), User.MAX_NAME_LENGTH),
                       'nickname': User.truncate_str(user.get('nickname'), User.MAX_URL_LENGTH),
                       'url': User.truncate_str(user.get('url'), User.MAX_NAME_LENGTH),
                       'avatar': User.parse_avatar(user.get('avatar')),
                       'sign': User.truncate_str(user.get('sign'), User.MAX_SIGN_LENGTH),
                       'user_group': user.get('usergroup')}

        return parsed_user

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

        return raw_str[:max_length - 2] + '..' if len(raw_str) > max_length else raw_str

    @staticmethod
    def parse_avatar(raw_avatar):
        """
        Parse raw avatar into a normalized one
        :param raw_avatar: raw avatar
        :return: parsed avatar
        """
        if not isinstance(raw_avatar, dict):
            return None

        max_image_url_length = 200

        parsed_images = {
            'large': raw_avatar.get('large', 'https://lain.bgm.tv/pic/user/l/icon.jpg')[:max_image_url_length],
            'medium': raw_avatar.get('medium', 'https://lain.bgm.tv/pic/user/m/icon.jpg')[:max_image_url_length],
            'small': raw_avatar.get('small', 'https://lain.bgm.tv/pic/user/s/icon.jpg')[:max_image_url_length],
        }

        return parsed_images

    def set_attribute(self, parsed_user):
        """
        Set attribute in user
        :param parsed_user:
        :return:
        """
        self.id = parsed_user.get('id')
        self.username = parsed_user.get('username')
        self.nickname = parsed_user.get('nickname')
        self.url = parsed_user.get('url')
        self.avatar = parsed_user.get('avatar')
        self.sign = parsed_user.get('sign')
        self.user_group = parsed_user.get('user_group')

    def diff_self_with_input(self, subject_dict):
        """
        Diff the input dict with current object
        :param subject_dict: a dict representation of the subject
        :return: a dictdiffer object
        """
        difference = diff(self.__dict__, subject_dict, ignore={'_sa_instance_state'})
        return difference
