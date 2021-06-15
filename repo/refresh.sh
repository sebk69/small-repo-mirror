#!/bin/bash

while [ 1 ]; do
  sleep 2592000
  rm -rf /root/archive.ubuntu.com
  cd /root && wget --recursive --level=100 --no-verbose --no-parent http://archive.ubuntu.com/ubuntu/dists/focal/ || echo "done"
  mv /usr/local/apache2/ubuntu/focal /root/old
  mv archive.ubuntu.com/ubuntu /usr/local/apache2/ubuntu
  rm -rf /root/old
done