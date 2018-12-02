#!/bin/sh

modprobe ipv6
opt/eth-interfaces.sh &
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

sudo zebra -u root -d -f /home/tc/conf/zebra.conf
sudo ospfd -u root -d -f /home/tc/conf/ospfd.conf
#sudo bgpd -u root -d -f /home/tc/conf/bgpd.conf

sudo keepalived -P -l -f /home/tc/conf/keepalived.conf
snmpd -C -c /home/tc/conf/snmpd.conf
#home/tc/changeroute.sh &
