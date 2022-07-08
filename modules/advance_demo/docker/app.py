from fastapi import FastAPI
from config.db import *
from fastapi.responses import JSONResponse
from starlette.status import HTTP_200_OK
import socket

hostname = (socket.gethostname())
app = FastAPI()

@app.get("/", status_code=HTTP_200_OK)
def read_root():
    db_status = test_db()
    return JSONResponse(content={
        "DB_Status": "{}".format(db_status['Status']),
        "DB_Host": "{}".format(MYSQL_HOST),
        "Hostname": "{}".format(hostname),
        "StatusCode": HTTP_200_OK
        })