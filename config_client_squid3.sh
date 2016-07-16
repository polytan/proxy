#!/bin/bash

echo "generate #G#F#W# whitelist/blacklist"
python list2regex.py
cp other.url_regex.lst cn.url_regex.lst /etc/squid/
cp other.url_regex.lst cn.url_regex.lst /etc/squid3/

echo "configure/run squid3"
cat >squid.conf <<EOF
http_port 3128
access_log /var/log/squid3/access.log squid
hosts_file /etc/hosts

acl LAN src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80 21 443 70 210 280 488 591 777 1025-65535
acl cn  dstdom_regex '/etc/squid3/cn.url_regex.lst'
acl other dstdom_regex '/etc/squid3/other.url_regex.lst'

# input stream control
http_access allow LAN
http_access deny all
http_access deny to_localhost
icp_access allow LAN
icp_access deny all

# domain control
prefer_direct on
always_direct deny other
never_direct allow other
never_direct deny cn

cache_peer 127.0.0.1 parent 1181 0 no-delay no-query
cache_peer_access 127.0.0.1 allow other
cache_dir ufs /var/spool/squid3 15360 16 256
cache_swap_low 85
cache_swap_high 90
cache_mem 1024 MB
cache_mgr yanlongtan@deepglint.com
maximum_object_size_in_memory 128 KB
cache_replacement_policy heap GDSF
maximum_object_size 4 MB

half_closed_clients off
memory_pools off
client_db off

#Enable Anonymizer (Anonymous Proxy)
#header_replace User-Agent anonymous
forwarded_for off
request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all
reply_header_access Allow allow all
reply_header_access Authorization allow all
reply_header_access WWW-Authenticate allow all
reply_header_access Proxy-Authorization allow all
reply_header_access Proxy-Authenticate allow all
reply_header_access Cache-Control allow all
reply_header_access Content-Encoding allow all
reply_header_access Content-Length allow all
reply_header_access Content-Type allow all
reply_header_access Date allow all
reply_header_access Expires allow all
reply_header_access Host allow all
reply_header_access If-Modified-Since allow all
reply_header_access Last-Modified allow all
reply_header_access Location allow all
reply_header_access Pragma allow all
reply_header_access Accept allow all
reply_header_access Accept-Charset allow all
reply_header_access Accept-Encoding allow all
reply_header_access Accept-Language allow all
reply_header_access Content-Language allow all
reply_header_access Mime-Version allow all
reply_header_access Retry-After allow all
reply_header_access Title allow all
reply_header_access Connection allow all
reply_header_access All deny all


#acl CONNECT method CONNECT
acl QUERY urlpath_regex cgi-bin/? .json .php .ts pipeline?.html
cache deny QUERY

#follow_x_forwarded_for allow whole

refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern (Release|Packages(.gz)*)$      0       20%     2880
refresh_pattern .               0       20%     4320

forwarded_for transparent

max_filedescriptors 181920
reply_header_max_size 6400 KB
chunked_request_body_max_size 0 KB
#vary_ignore_expire on
EOF

cp squid.conf /etc/squid3/
cp squid.conf /etc/squid/

service squid3 restart || true
service squid restart || true

