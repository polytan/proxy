#!/bin/bash


echo "configure/run shadowsocks-libev client"
cp shadowsocks-libev.init /etc/init.d/shadowsocks-libev
cat >/etc/shadowsocks-libev/config.json <<EOF
{
    "server":"127.0.0.1",
    "server_port":8889,
    "local_port":1080,
    "password":"dell@2016",
    "timeout":60,
    "method":null
}
EOF

cat >/etc/default/shadowsocks-libev <<EOF
# Defaults for shadowsocks initscript
# sourced by /etc/init.d/shadowsocks-libev
# installed at /etc/default/shadowsocks-libev by the maintainer scripts

#
# This is a POSIX shell fragment
#
# Note: `START', `GROUP' and `MAXFD' options are not recognized by systemd.
# Please change those settings in the corresponding systemd unit file.

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
MAXFD=1024
EOF

service shadowsocks-libev restart


