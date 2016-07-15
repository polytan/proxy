#!/bin/bash

./tune_sysctl.sh

./config_client_haproxy.sh

./config_client_shadowsocks.sh

./config_client_privoxy.sh

./config_client_squid3.sh


