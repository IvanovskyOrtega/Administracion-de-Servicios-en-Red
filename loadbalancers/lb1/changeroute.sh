#!/bin/sh

ip route flush dev eth0
ip route flush dev eth1
ip route add 10.0.2.0/24 proto kernel scope link src 10.0.2.11 dev eth0
ip route add default 10.0.2.20
eth0=eth0
eth1=eth1
master_ip=10.0.2.1
backup_ip=10.0.2.2
master_interface=$eth0
backup_interface=$eth1
while :
do
	ping -c 1 -I $master_interface -W 1 10.0.2.20 > /dev/null 2>&1
	ping_route=$?
	if [ $ping_route -ne 0 ]; then
		echo "Backup interface working"
		aux=$master_interface
		master_interface=$backup_interface
		backup_interface=$aux
		aux=$master_ip
		master_ip=$backup_ip
		backup_ip=$aux
		ip route flush dev $backup_interface
		ip route add 10.0.2.0/24 proto kernel scope link src $master_ip dev $master_interface
		ip route add default 10.0.2.20
	fi
	if [ $master_interface != $eth0 ]; then
		ping -c 1 -I eth0 -W 1 10.0.2.20 > /dev/null 2>&1
		ping_route=$?
		if [ $ping_route -eq 0 ]; then
			echo "Master Interface recovered"
			master_interface=$eth0
			backup_interface=$eth1
			master_ip=10.0.2.1
			backup_ip=10.0.2.2
			ip route flush dev $backup_interface
			ip route add 10.0.2.0/24 proto kernel scope link src $master_ip dev $master_interface
			ip route add default 10.0.2.20
		fi
	fi
	sleep 1
done
