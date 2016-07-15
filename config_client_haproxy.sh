#!/bin/bash


echo "configure/run haproxy, please replace ip of shadowsocks_backend to your own ip address"
echo "note: this is the configuration of haproxy 1.4.24, new version may vary"
cat >/etc/default/haproxy <<EOF
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1
# Add extra flags here.
#EXTRAOPTS="-de -m 16"
EOF

cat >/etc/haproxy/haproxy.conf <<EOF
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

defaults
        log     global
        mode    tcp
        option  tcplog
        option  dontlognull
        contimeout 50000
        clitimeout 50000
        srvtimeout 50000

listen stats *:1936
    stats enable
    stats uri /
    stats hide-version
    stats auth admin:admin

frontend shadowsocks
    bind 127.0.0.1:8889
    mode tcp
    option tcplog
    maxconn 102400
    default_backend shadowsocks_backend

backend shadowsocks_backend
    mode tcp
    balance leastconn
    server web01 <server1>:8889 check inter 61000 rise 2 fall 2
    server web02 <server2>:8889 check inter 61000 rise 2 fall 2
    server web03 <server3>:8889 check inter 61000 rise 2 fall 2
EOF
service haproxy restart


