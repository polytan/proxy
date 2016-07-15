#!/bin/bash

cat >/etc/sysctl.conf <<EOF
fs.file-max = 102400
fs.nr_open = 102400

# allow buffers up to 128MB (RTT up to 200ms)
net.core.rmem_max = 134217728
net.core.wmem_max = 134217728
# autoruning TCP buffer limit to 64MB
#net.ipv4.tcp_mem = 25600 51200 102400
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
# length of the processor input queue
net.core.netdev_max_backlog = 250000
# congestion control
net.ipv4.tcp_congestion_control=cubic

net.core.somaxconn = 4096

net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.ipv4.ip_local_port_range = 1500     65535

EOF
sysctl -p

