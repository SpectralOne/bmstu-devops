#!/bin/sh
# stub_status
STATUS_PAGE=$(curl http://localhost:80/status)

IS_ACTIVE=$(systemctl is-active --quiet nginx.service && echo 1 || echo 0)
ACTIVE=$(echo $STATUS_PAGE | awk '{print $3}')
[ -z "$ACTIVE" ] && ACTIVE=0
ACCEPTS=$(echo $STATUS_PAGE | awk '{print $8}')
[ -z "$ACCEPTS" ] && ACCEPTS=0
HANDLED=$(echo $STATUS_PAGE | awk '{print $9}')
[ -z "$HANDLED" ] && HANDLED=0
REQUESTS=$(echo $STATUS_PAGE | awk '{print $10}')
[ -z "$REQUESTS" ] && REQUESTS=0
READING=$(echo $STATUS_PAGE | awk '{print $12}')
[ -z "$READING" ] && READING=0
WRITING=$(echo $STATUS_PAGE | awk '{print $14}')
[ -z "$WRITING" ] && WRITING=0
WAITING=$(echo $STATUS_PAGE | awk '{print $16}')
[ -z "$WAITING" ] && WAITING=0

DATA="
nginx_is_active $IS_ACTIVE\n\
nginx_active_connections $ACTIVE\n\
nginx_acceptes_connections $ACCEPTS\n\
nginx_handled_connections $HANDLED\n\
nginx_requests $REQUESTS\n\
nginx_reading_connections $READING\n\
nginx_writing_connections $WRITING\n\
nginx_waiting_connections $WAITING"

echo $DATA > /var/metrics/nginx-metrics.prom

# dir size
INFO=$(du -sb "/var/lib/prometheus" | sed -ne 's/\\/\\\\/;s/"/\\"/g;s/^\([0-9]\+\)\t\(.*\)$/node_directory_size_bytes{directory="\2"} \1/p')

echo $INFO > /var/metrics/dir-size.prom
