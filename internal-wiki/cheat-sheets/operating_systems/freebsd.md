# FreeBSD Essentials

## Networking
Issue | Solution
---|---
Upgrade packages | `pkg update`
Set HTTP proxy|`setenv HTTP_PROXY http://proxy.berke1337.org:8080/`
configure DHCP|in file `/etc/rc.conf` set `ifconfig_em0="DHCP"`
configure static ip|in file `/etc/rc.conf` set `ifconfig_em0="inet 10.10.10.100 netmask 255.255.255.0" defaultrouter="10.10.10.1"`
restart networking | `/etc/rc.d/netif restart && /etc/rc.d/routing restart`

## User Management
Issue | Solution
---|---
add user | `adduser`
add group |`pw groupadd teamtwo`
add user to group | `pw groupmod teamtwo -M peter`
