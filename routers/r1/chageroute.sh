#!/bin/sh

ip route add 10.0.1.0/24 via 10.0.1.11 dev eth1
eth1=eth1
eth2=eth2
master_ip=10.0.1.11
backup_ip=10.0.1.12
master_interface=$eth1
backup_interface=$eth2
while :
do
	ping -c 1 -I $master_interface -W 1 10.0.1.10 > /dev/null 2>&1
	ping_route=$?
	if [ $ping_route -ne 0 ]; then
		aux=$master_interface
		master_interface=$backup_interface
		backup_interface=$aux
		aux=$master_ip
		master_ip=$backup_ip
		backup_ip=$aux
		ip route flush dev $backup_interface
		ip route add 10.0.1.0/24 via $master_ip dev $master_interface
	fi
	if [ $master_interface -ne $eth1 ]; then
		ping -c 1 -I $master_interface -W 1 10.0.1.10 > /dev/null 2>&1
		ping_route=$?
		if [ $ping_route -eq 0 ]; then
			master_interface=$eth1
			backup_interface=$eth2
			master_ip=10.0.1.11
			backup_ip=10.0.1.12
			ip route flush dev $backup_interface
			ip route add 10.0.1.0/24 via $master_ip dev $master_interface
		fi
	fi
	sleep 1
done
