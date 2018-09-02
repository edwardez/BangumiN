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
        self.parse_input(user)

    def __repr__(self):
        return '<User(id = %s, username = %s)>' % (self.id, self.username)

    def update(self, user):
        self.parse_input(user)

    def parse_input(self, user):
        self.id = user.get('id')
        self.username = self.truncate_str(user.get('username'), self.MAX_NAME_LENGTH)
        self.nickname = self.truncate_str(user.get('nickname'), self.MAX_URL_LENGTH)
        self.url = self.truncate_str(user.get('url'), self.MAX_NAME_LENGTH)
        self.avatar = self.parse_avatar(user.get('avatar'))
        self.sign = self.truncate_str(user.get('sign'), self.MAX_SIGN_LENGTH)
        self.user_group = user.get('usergroup')

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
