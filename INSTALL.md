# SETUP server
### experimental is 5$ vultr server located at japan
```
> ./install_server.sh
# before configure server, do following configuration for config_server.sh
# set "server_port" if you want to change port number
# set "password" if you want to change password
> ./config_server.sh
# now server must up and running, check it by check the listen address
> lsof -i | grep LISTEN
# now the port which you set at "server_port" must opened
```


# SETUP client
### experimental is ubuntu 14.04 server(64bit) 
```
# if you do not have vpn access currently, you'd better download the shadowsocks from server
# so run this commnd at your server: apt-get download shadowsocks-libev
# scp the package shadowsocks-libev_2.4.0-1_amd64.deb to your local server
> dpkg -i shadowsocks-libev_2.4.0-1_amd64.deb
> ./install_client.sh
# after install success, do following configurations 
# config_client_haproxy.sh: check the section of shadowsocks_backend
    - <server*>:8889 to the <remote ip>:<server_port> of your remote server
    - delete items which you don't want
    - add new items if you have more servers
# config_client_shadowsocks.sh: change password to the one you set in remote server, here, the 'server_port' is balanced by haproxy, it must equal to haproxy's frontend bind port
# config_client_privoxy.sh: maybe no change required
# config_client_squid3.sh: change 'http_port' if you want to change proxy port
> ./config_client.sh
```


# TESTED CONNECTION ...
### experimental: chrome with Proxy SwitchySharp or Proxy SwitchOmega
### experimental: is firefox http proxy


