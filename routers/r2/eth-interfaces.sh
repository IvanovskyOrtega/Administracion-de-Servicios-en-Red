#!/bin/sh
ifconfig eth0 192.168.1.1 netmask 255.255.255.0 up
ifconfig eth1 10.0.1.13 netmask 255.255.255.0 up
ifconfig eth2 10.0.1.14 netmask 255.255.255.0 up
ip route add default via 192.168.1.254 dev eth0