#!/bin/bash

# sync every month
while [ 1 ]; do
  # tell sync in progress
  echo "active" > /usr/local/apache2/htdocs/syncing

  echo "**** Mirror unmaintained ubutnu releases"
  # only if not downloaded before : unmaintained repos is static - it is recommended to have persistent volume on /root/archive.ubuntu.com
  [ -f /root/old-releases.ubuntu.com/done ] && echo "already downloaded" || \
      cd /root && wget --mirror --no-verbose --no-parent --tries=0 --timeout=0 ftp://old-releases.ubuntu.com/ubuntu/ && \
      touch /root/old-releases.ubuntu.com/done
  # fusion to maintened ubuntu repo in order to serve all dist in one place
  echo "syncing"
  cd /root/old-releases.ubuntu.com && rsync -rt ubuntu /root/archive.ubuntu.com

  echo "**** Mirror unmaintained ubutnu releases"
  cd /root && wget --mirror --no-verbose --no-parent --tries=0 --timeout=0 ftp://archive.ubuntu.com/ubuntu/

  echo "**** Mirror debian releases"
  cd /root && wget --mirror --no-verbose --no-parent --tries=0 --timeout=0 ftp://deb.debian.org/debian/

  echo "**** Move mirrors to http server"
  mv /root/archive.ubuntu.com/ubuntu /usr/local/apache2/htdocs/ubuntu
  mv /root/deb.debian.org/debian /usr/local/apache2/htdocs/debian

  echo "healthy"
  echo "ok" > /usr/local/apache2/htdocs/healthz

  # tell sync in progress
  echo "inactive" > /usr/local/apache2/htdocs/syncing

  # wait one month
  sleep 2592000
done