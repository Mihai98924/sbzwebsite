#!/bin/bash

source /app/venv/bin/activate
python3 manage.py migrate
python3 manage.py collectstatic --noinput
python3 manage.py compilemessages
# python3 manage.py runserver 0.0.0.0:8000

uwsgi \
    --chdir /app \
    --socket 0.0.0.0:8080 \
    --uid uwsgi \
    --plugins python3 \
    --home /app/venv \
    --protocol http \
    --master \
    --vacuum \
    --max-requests 5000 \
    --processes 2 \
    --wsgi settings.wsgi
