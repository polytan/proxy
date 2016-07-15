#!/bin/bash

wget -O- http://shadowsocks.org/debian/1D27208A.gpg | sudo apt-key add -
echo "deb http://shadowsocks.org/ubuntu trusty main" >>/etc/apt/sources.list.d/shadowsocks.list
apt-get -y update
#versions: shadowsocks-libev=2.4.0-1
apt-get -y install shadowsocks-libev htop iftop iotop
