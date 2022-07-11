FROM python:3.9
LABEL maintainer="@JManzur"

WORKDIR /usr/src/app/

COPY requirements.txt /usr/src/app/
COPY app.py /usr/src/app/
ADD config /usr/src/app/config

ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWD=${MYSQL_PASSWD}
ENV MYSQL_HOST=${MYSQL_HOST}
ENV MYSQL_PORT=${MYSQL_PORT}
ENV MYSQL_DB=${MYSQL_DB}
ENV AWS_DEFAULT_REGION=${AWS_REGION}

RUN pip install --no-cache-dir --upgrade -r /usr/src/app/requirements.txt

EXPOSE 8048

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8048"]