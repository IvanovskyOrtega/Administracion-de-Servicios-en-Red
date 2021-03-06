#!/bin/sh

ip route flush dev eth4
ip route flush dev eth5
ip route add 10.0.2.0/24 proto kernel scope link src 10.0.2.13 dev eth4
eth4=eth4
eth5=eth5
master_ip=10.0.2.13
backup_ip=10.0.2.14
master_interface=$eth4
backup_interface=$eth5
while :
do
	ping -c 1 -I $master_interface -W 1 10.0.2.10 > /dev/null 2>&1
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
	fi
	if [ $master_interface != $eth4 ]; then
		ping -c 1 -I eth4 -W 1 10.0.2.10 > /dev/null 2>&1
		ping_route=$?
		if [ $ping_route -eq 0 ]; then
			echo "Master Interface recovered"
			master_interface=$eth4
			backup_interface=$eth5
			master_ip=10.0.2.13
			backup_ip=10.0.2.14
			ip route flush dev $backup_interface
			ip route add 10.0.2.0/24 proto kernel scope link src $master_ip dev $master_interface
		fi
	fi
	sleep 1
done
