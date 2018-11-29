#!/bin/sh

#Load default firewall rules
/home/tc/healthcheck/bothServers.sh
s1p=0
s2p=0
s1c=0
s2c=0
changed=0
while :
do
	ping -c 1 -W 1 10.0.3.101 > /dev/null 2>&1
	pingS1=$?
	ping -c 1 -W 1 10.0.3.102 > /dev/null 2>&1
	pingS2=$?
	if [ $pingS1 -eq 0 ]; then
		s1c=0
	else
		s1c=1
	fi
	if [ $pingS2 -eq 0 ]; then
		s2c=0
	else
		s2c=1
	fi
	if [ $s1c -eq $s1p ] && [ $s2c -eq $s2p ]; then
		changed=0
	else
		changed=1
	fi
	if [ $changed -eq 1 ]; then
		if [ $s1c -eq 0 ] && [ $s2c -eq 0 ]; then
			/home/tc/healthcheck/bothServers.sh
			echo "Server #1 up, Server #2 up"
		elif [ $s1c -eq 1 ] && [ $s2c -eq 0 ]; then
			/home/tc/healthcheck/oneServer.sh 10.0.3.102
			echo "Server #1 down, Server #2 up"
		elif [ $s1c -eq 0 ] && [ $s2c -eq 1 ]; then
			/home/tc/healthcheck/oneServer.sh 10.0.3.101
			echo "Server #1 up, Server #2 down"
		fi
	fi
	s1p=$s1c
	s2p=$s2c
	sleep 1
done
