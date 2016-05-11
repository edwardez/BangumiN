import json
from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String, Date
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import sys

MYSQL_HOST = 'localhost'
MYSQL_DBNAME = 'bgm'
MYSQL_USER = 'bgmer'
MYSQL_PASSWD = 'sai'

Base = declarative_base()

# Declare mapping here

class User(Base):
    __tablename__ = 'users'

    name = Column(String(50), primary_key=True, index=True, unique=True)
    nickname = Column(String(50))
    uid = Column(Integer, nullable=False)
    joindate = Column(Date, nullable=False)
    activedate = Column(Date, nullable=False)

    def __repr__(self):
        return "<Users(uid='%s', name='%s', joindate='%s')>" % (
            self.uid, self.name, self.joindate)

class Record(Base):
    __tablename__ = 'record'

    name = Column(String(50), primary_key=True, index=True)
    typ = Column(String(5), nullable = False)
    iid = Column(Integer, primary_key=True, index=True)
    state = Column(String(7), nullable = False)
    adddate = Column(Date, nullable = False)
    rate = Column(Integer)
    rate = Column(String(500))

    def __repr__(self):
        return "<Record(name=%s, iid=%s, typ=%s, state=%s)>"% (self.name,
        self.iid, self.typ, self.state)

engine = create_engine("mysql+mysqldb://" + MYSQL_USER + ":" + MYSQL_PASSWD + "@" +
                       MYSQL_HOST + "/" + MYSQL_DBNAME +
                       "?charset=utf8&use_unicode=0&unix_socket=/var/run/mysqld/mysqld.sock")
Base.metadata.create_all(engine)

# Session is a custom class
Session = sessionmaker(bind=engine)
session = Session()


def store_users():
    with open("user.json", 'rb') as fr:
        cnt=0
        while True:
            rec = fr.readline().strip()
            cnt+=1
            if not rec: break;

            user = json.loads(rec)
            user_instance = User(name = user['name'], nickname = user['nickname'], uid = user['uid'],
                                 joindate=user['joindate'], activedate = user['activedate'])
            session.add(user_instance)
            if cnt%10000==0:
                session.commit()
    session.commit()

def store_record():
    with open("record.json", 'rb') as fr:
        cnt=0
        while True:
            rec = fr.readline().strip()
            cnt+=1
            if not rec: break;

            record = json.loads(rec)
            tags = record.get('tags',None)
            if tags:
                tags = u" ".join(tags)
            record_instance = Record(name = record['name'], typ=record['typ'], iid=record['iid'], state=record['state'],
                                    adddate=record['adddate'], rate=record.get('rate', None), tags = tags)
            session.add(record_instance)
            if cnt%10000==0:
                session.commit()
    session.commit()

def run():
    if sys.argv[1]=='users':
        store_users()
    elif sys.argv[1]=='record':
        store_record()

if __name__=='__main__':
    run()
