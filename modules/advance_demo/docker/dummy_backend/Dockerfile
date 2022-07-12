FROM python:latest
LABEL maintainer="@JManzur"
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app/

RUN apt-get update && apt-get install -y iputils-ping jq telnet apt-utils

COPY requirements.txt /usr/src/app/
COPY app.py /usr/src/app/

RUN pip install --no-cache-dir --upgrade -r /usr/src/app/requirements.txt

EXPOSE 8049

ENV AWS_DEFAULT_REGION=${AWS_REGION}

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8049"]