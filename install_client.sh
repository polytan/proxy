#!/bin/bash

echo "client could not download shadowsocks, please ssh to your server"
echo "download the packages using command: apt-get download shadowsocks-libev then scp the downloaded package into your local machine"
echo "after that, install it use dpkg -i <package>.deb"

#curl http://shadowsocks.org/debian/1D27208A.gpg | sudo apt-key add -
#echo "deb http://shadowsocks.org/ubuntu trusty main" >>/etc/apt/sources.list.d/shadowsocks.list
apt-get -y update
#versions: shadowsocks-libev=2.4.0-1, privoxy=3.0.21-2, haproxy=1.4.24-2, squid=3.3.8-1ubuntu6
apt-get -y install privoxy haproxy squid #shadowsocks-libev




