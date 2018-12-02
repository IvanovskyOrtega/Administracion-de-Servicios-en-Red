#!/bin/sh
ifconfig eth0 up # Configurada por Zebra
ifconfig eth1 up # Configurada por Zebra
ifconfig eth2 up # Configurada por Keepalived
ifconfig eth3 up # Configurada por Keepalived
ifconfig eth4 10.0.3.1 netmask 255.255.255.0 up
ifconfig eth5 10.0.3.2 netmask 255.255.255.0 up
