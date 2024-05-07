FROM python:3.10-slim

# Install required packages for symposia
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    libjpeg-dev \
    libtiff5-dev \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    tcl8.6-dev \
    tk8.6-dev \
    # python-tk \
    # python3-pip \
    gettext

# Install other packages needed for deployment
RUN apt-get install -y git media-types

# Clean up apt caches
RUN apt-get clean

# Create directory for Symposia app
RUN mkdir -p /app

# Set up a Virtual Environment
RUN python3 -m venv /app/venv

# Install pip packages
COPY requirements.txt /app/requirements.txt
RUN /app/venv/bin/pip install -r /app/requirements.txt
RUN /app/venv/bin/pip install uwsgi

# Copy over codebase
COPY . /app

# Create the `uwsgi` user
RUN useradd -Ms /bin/bash uwsgi
RUN chown -R uwsgi:uwsgi /app
USER uwsgi

WORKDIR /app
EXPOSE 8080/tcp
CMD ["bash", "/app/docker-entrypoint.sh"]
