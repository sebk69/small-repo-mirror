#!/bin/bash

while ps -p $1 > /dev/null; do sleep 1; done
rm /usr/local/apache2/htdocs/healthz