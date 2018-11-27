#!/bin/sh
ifconfig eth0 10.0.1.3 netmask 255.255.255.0 up
ifconfig eth1 10.0.1.4 netmask 255.255.255.0 up
ifconfig eth2 up # Configurada por Keepalived
ifconfig eth3 up # Configurada por Keepalived
ifconfig eth4 10.0.2.13 netmask 255.255.255.0 up
ifconfig eth5 10.0.2.14 netmask 255.255.255.0 up