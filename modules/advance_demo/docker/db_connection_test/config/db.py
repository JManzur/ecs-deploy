from sqlalchemy import create_engine, MetaData
from os import getenv
from dotenv import load_dotenv
load_dotenv()

MYSQL_USER = getenv("MYSQL_USER")
MYSQL_PASSWD = getenv("MYSQL_PASSWD")
MYSQL_HOST = getenv("MYSQL_HOST")
MYSQL_PORT = getenv("MYSQL_PORT")
MYSQL_DB = getenv("MYSQL_DB")

engine = create_engine('mysql+pymysql://{}:{}@{}:{}/{}'.format(
    MYSQL_USER,
    MYSQL_PASSWD,
    MYSQL_HOST,
    MYSQL_PORT,
    MYSQL_DB
    ))

meta = MetaData()
db_connection = engine.connect()

def test_db():
    try:
        db_connection
        return {"Status": "Connect"}
    except Exception as ex:
        return {"Status": "Connection failed"}