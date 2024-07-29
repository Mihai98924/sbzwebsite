FROM python:3.12-slim

# Install required packages for sbzwebsite
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

# Create directory for SBZ app
RUN mkdir -p /app

# Copy over codebase
COPY . /app

WORKDIR /app

# Set up a Virtual Environment
RUN python3 -m venv /venv

# Install pip packages
COPY requirements.txt requirements.txt
RUN /venv/bin/pip install -r requirements.txt
RUN /venv/bin/pip install uwsgi

# Create the `uwsgi` user
RUN useradd -Ms /bin/bash uwsgi
RUN chown -R uwsgi:uwsgi /app
USER uwsgi


EXPOSE 8080/tcp
CMD ["bash", "docker-entrypoint.sh"]
