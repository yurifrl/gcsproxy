#!/bin/bash
  
# turn on bash's job control
set -m
  
# Start the primary process and put it in the background
cp /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf

nginx
# Start the helper process
/gcsproxy
  
# the my_helper_process might need to know how to wait on the
# primary process to start before it does its work and returns
  
  
# now we bring the primary process back into the foreground
# and leave it there
fg %1