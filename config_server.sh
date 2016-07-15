#!/bin/bash

./tune_sysctl.sh

#note: server_port is the entry key
cat >/etc/shadowsocks-libev/config.json <<EOF
{
    "server":"0.0.0.0",
    "server_port":8889,
    "local_port":1180,
    "password":"dell@2016",
    "timeout":60,
    "method":null
}
EOF

cat >/etc/default/shadowsocks-libev <<EOF
# Enable during startup?
START=yes

# Configuration file
CONFFILE="/etc/shadowsocks-libev/config.json"

# Extra command line arguments
DAEMON_ARGS="-v --fast-open"

# User and group to run the server as
USER=root
GROUP=root

# Number of maximum file descriptors
MAXFD=102400
EOF

#start shadowsocks
service shadowsocks-libev restart


