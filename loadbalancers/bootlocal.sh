#!/bin/sh
modprobe ipv6
opt/eth-interfaces.sh &
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
home/tc/healthcheck/healthcheck.sh &
home/tc/changeroute.sh &
sudo keepalived -P -l -f /home/tc/conf/keepalived.conf
sudo snmpd -C -c /home/tc/conf/snmpd.conf
