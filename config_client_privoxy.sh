#!/bin/bash

echo "configure/run privoxy"
cat >/etc/privoxy/config <<EOF
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
logdir /var/log/privoxy
actionsfile match-all.action 
actionsfile default.action   
actionsfile user.action      
filterfile default.filter
filterfile user.filter      
logfile logfile
debug     1 
debug  4096 
debug  8192 
listen-address  0.0.0.0:1181
toggle  1
enable-remote-toggle  0
enable-remote-http-toggle  0
enable-edit-actions 1
enforce-blocks 0
buffer-limit 4096
enable-proxy-authentication-forwarding 0
forward-socks5 / 127.0.0.1:1080 .
forwarded-connect-retries  0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 10
tolerate-pipelining 1
socket-timeout 300
EOF
service privoxy restart

