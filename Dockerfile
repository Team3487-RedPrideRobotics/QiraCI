FROM balenalib/raspberrypi3-alpine-python

ENV PYTHONUNBUFFERED 1

RUN mkdir /qira-ci

WORKDIR /qira-ci

COPY requirements.txt /qira-ci/

RUN apk update && \
    apk add --virtual build-deps python3-dev gcc musl-dev git && \
    apk add postgresql-dev
RUN python3 -m pip install -r requirements.txt

COPY . /qira-ci/

CMD python3 manage.py makemigrations; python3 manage.py migrate; python3 manage.py runserver 0.0.0.0:8000
