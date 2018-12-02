#!/bin/sh
ifconfig eth0 10.0.2.1 netmask 255.255.255.0 up
ifconfig eth1 10.0.2.2 netmask 255.255.255.0 up
ifconfig eth2 up # Configurada por Keepalived
ifconfig eth3 10.0.3.1 netmask 255.255.255.0 up
ifconfig eth4 10.0.3.2 netmask 255.255.255.0 up
ifconfig eth5 up # Configurada por Keepalived
