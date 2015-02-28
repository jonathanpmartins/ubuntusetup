#!/bin/sh

nginx_log() {
  while inotifywait -e modify /var/log/nginx/error.log; do
    line=$(tail -n1 /var/log/nginx/error.log | cut -c 81-);
    notify-send "$line"; 
  done
}

nginx_log