FROM python:3.9
LABEL maintainer="@JManzur"

WORKDIR /usr/src/app/

COPY requirements.txt /usr/src/app/
COPY app.py /usr/src/app/

RUN pip install --no-cache-dir --upgrade -r /usr/src/app/requirements.txt

EXPOSE 8049

ENV AWS_DEFAULT_REGION=${AWS_REGION}

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8049"]