from fastapi import FastAPI
from starlette.status import HTTP_200_OK
from fastapi.responses import JSONResponse
import socket

hostname = (socket.gethostname())
app = FastAPI()

@app.get("/", status_code=HTTP_200_OK)
async def root():
    return JSONResponse(content={
        'Message': 'Hello from {}'.format(hostname)
        })

@app.get('/status', status_code=HTTP_200_OK)
async def perform_healthcheck():
    return JSONResponse(content={
        'healthcheck': 'Everything OK!'
        })