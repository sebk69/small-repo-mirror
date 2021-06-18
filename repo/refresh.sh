#!/bin/bash

# sync every month
while [ 1 ]; do
  # tell sync in progress
  echo "active" > /usr/local/apache2/htdocs/syncing

  echo "**** Mirror unmaintained ubutnu releases"
  # only if not downloaded before : unmaintained repos is static - it is recommended to have persistent volume on /root/archive.ubuntu.com
  [ -f /root/old-releases.ubuntu.com/done ] && echo "already downloaded" || \
      cd /root && \
      wget \
         --mirror \
         --no-verbose \
         --no-parent \
         --tries=0 \
         --timeout=0 \
         --timestamping \
         --exclude-directories=/old-images/ubuntu/.temp \
         ftp://old-releases.ubuntu.com/old-images/ubuntu && \
      touch /root/old-releases.ubuntu.com/done
  # fusion to maintened ubuntu repo in order to serve all dist in one place
  echo "syncing"
  cd /root/old-releases.ubuntu.com/old-images && rsync -rt ubuntu /root/archive.ubuntu.com

  echo "**** Mirror maintained ubutnu releases"
  cd /root && wget --mirror --no-verbose --no-parent --tries=0 --timeout=0 --timestamping ftp://archive.ubuntu.com/ubuntu/ &

  echo "**** Mirror debian releases"
  cd /root && wget --mirror --no-verbose --no-parent --tries=0 --timeout=0 --timestamping ftp://deb.debian.org/debian/ &

  wait

  echo "**** Move mirrors to http server"
  rm -rf /root/old || echo "Old not present"
  mv /usr/local/apache2/htdocs/ubuntu /root/old
  mv /root/archive.ubuntu.com/ubuntu /usr/local/apache2/htdocs/ubuntu
  rm -rf /root/old || echo "Old not present"
  mv /usr/local/apache2/htdocs/debian /root/old
  mv /root/deb.debian.org/debian /usr/local/apache2/htdocs/debian

  echo "healthy"
  echo "ok" > /usr/local/apache2/htdocs/healthz

  # tell sync in progress
  echo "inactive" > /usr/local/apache2/htdocs/syncing

  # wait one month
  sleep 2592000
done