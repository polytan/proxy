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

service shadowsocks-libev restart


