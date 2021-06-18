cd /root

# launch repo refresh async
nohup ./refresh.sh &
PID=$!

# disable health route if sync process fail
nohup ./health.sh $PID &

# serve http
httpd-foreground