#!/bin/bash


echo "configure/run shadowsocks-libev client"
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

cat /etc/init.d/shadowsocks-libev | sed 's/ss-server/ss-local/g' >/etc/init.d/shadowsocks-libev

service shadowsocks-libev restart


