FROM python:3.12-alpine

# # Install required packages for sbzwebsite
# RUN apt-get update && apt-get install -y \
#     default-libmysqlclient-dev \
#     libjpeg-dev \
#     libtiff5-dev \
#     libjpeg-dev \
#     zlib1g-dev \
#     libfreetype6-dev \
#     liblcms2-dev \
#     libwebp-dev \
#     tcl8.6-dev \
#     tk8.6-dev \
#     # python-tk \
#     python3-pip \
#     gettext

# # Install other packages needed for deployment
# RUN apt-get install -y git media-types

# # Clean up apt caches
# RUN apt-get clean

RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache mariadb-dev \
    && apk add linux-headers pcre-dev 

# Create directory for SBZ app
RUN mkdir -p /app

# Copy over codebase
COPY . /app

WORKDIR /app

# Install pip packages
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN pip3 install uwsgi

# Create the `uwsgi` user
# RUN useradd -Ms /bin/bash uwsgi
# RUN chown -R uwsgi:uwsgi /app
# USER uwsgi

USER 1000:1000


EXPOSE 8080/tcp
# RUN chmod +x "/app/docker-entrypoint.sh"
# ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["bash", "docker-entrypoint.sh"]
