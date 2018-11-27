#!/bin/sh
ifconfig eth0 10.0.1.1 netmask 255.255.255.0 up
ifconfig eth1 10.0.1.2 netmask 255.255.255.0 up
ifconfig eth2 up # Configurada por Keepalived
ifconfig eth3 up # Configurada por Keepalived
ifconfig eth4 10.0.2.11 netmask 255.255.255.0 up
ifconfig eth5 10.0.2.12 netmask 255.255.255.0 up