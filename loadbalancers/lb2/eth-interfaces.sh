#!/bin/sh
ifconfig eth0 10.0.2.3 netmask 255.255.255.0 up
ifconfig eth1 10.0.2.4 netmask 255.255.255.0 up
ifconfig eth2 up # Configurada por Keepalived
ifconfig eth3 10.0.3.3 netmask 255.255.255.0 up
ifconfig eth4 10.0.3.4 netmask 255.255.255.0 up