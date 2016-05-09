import json
from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String, Date
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

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

engine = create_engine("mysql+mysqldb://" + MYSQL_USER + ":" + MYSQL_PASSWD + "@" +
                       MYSQL_HOST + "/" + MYSQL_DBNAME +
                       "?charset=utf8&use_unicode=0&unix_socket=/var/run/mysqld/mysqld.sock")
Base.metadata.create_all(engine)

# Session is a custom class
Session = sessionmaker(bind=engine)
session = Session()


def main():
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
            if cnt%10==0:
                session.commit()
    session.commit()

if __name__=='__main__':
    main()
