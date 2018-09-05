from sqlalchemy import Column, Integer
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class UserExclude(Base):
    __tablename__ = 'user_exclude'

    id = Column('user_id', Integer, primary_key=True)

    def __init__(self, user):
        self.id = user.id

    def __repr__(self):
        return '<UserExclude(id = %s)>' % self.id
