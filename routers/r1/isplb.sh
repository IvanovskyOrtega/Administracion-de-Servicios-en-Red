#!/bin/sh
echo "10 ISP1" >> /etc/iproute2/rt_tables
echo "20 ISP2" >> /etc/iproute2/rt_tables
ip route show table main | grep -Ev '^default' \
   | while read ROUTE ; do
     ip route add table ISP1 $ROUTE
done
ip route add default via 192.168.0.1 table ISP1
ip route add default via 192.168.1.1 table ISP2
iptables -t mangle -A PREROUTING -j CONNMARK --restore-mark
iptables -t mangle -A PREROUTING -m mark ! --mark 0 -j ACCEPT
iptables -t mangle -A PREROUTING -j MARK --set-mark 10
iptables -t mangle -A PREROUTING -m statistic --mode random --probability 0.5 -j MARK --set-mark 20
iptables -t mangle -A PREROUTING -j CONNMARK --save-mark

isp1p=0
isp2p=0
isp1c=0
isp2c=0
changed=0
while :
do
	ping -c 1 -W 1 10.0.3.101 > /dev/null 2>&1
	pingISP1=$?
	ping -c 1 -W 1 10.0.3.102 > /dev/null 2>&1
	pingISP2=$?
	if [ $pingISP1 -eq 0 ]; then
		isp1c=0
	else
		isp1c=1
	fi
	if [ $pingISP2 -eq 0 ]; then
		isp2c=0
	else
		isp2c=1
	fi
	if [ $isp1c -eq $isp1p ] && [ $isp2c -eq $isp2p ]; then
		changed=0
	else
		changed=1
	fi
	if [ $changed -eq 1 ]; then
		if [ $isp1c -eq 0 ] && [ $isp2c -eq 0 ]; then
			echo "ISP1 up, ISP2 up"
			iptables -t mangle --flush
			iptables -t mangle -A PREROUTING -j CONNMARK --restore-mark
			iptables -t mangle -A PREROUTING -m mark ! --mark 0 -j ACCEPT
			iptables -t mangle -A PREROUTING -j MARK --set-mark 10
			iptables -t mangle -A PREROUTING -m statistic --mode random --probability 0.5 -j MARK --set-mark 20
			iptables -t mangle -A PREROUTING -j CONNMARK --save-mark
		elif [ $isp1c -eq 1 ] && [ $isp2c -eq 0 ]; then
			iptables -t mangle --flush
			iptables -t mangle -A PREROUTING -j CONNMARK --restore-mark
			iptables -t mangle -A PREROUTING -m mark ! --mark 0 -j ACCEPT
			iptables -t mangle -A PREROUTING -j MARK --set-mark 20
			iptables -t mangle -A PREROUTING -j CONNMARK --save-mark
			echo "ISP1 down, ISP2 up"
		elif [ $isp1c -eq 0 ] && [ $isp2c -eq 1 ]; then
			iptables -t mangle --flush
			iptables -t mangle -A PREROUTING -j CONNMARK --restore-mark
			iptables -t mangle -A PREROUTING -m mark ! --mark 0 -j ACCEPT
			iptables -t mangle -A PREROUTING -j MARK --set-mark 10
			iptables -t mangle -A PREROUTING -j CONNMARK --save-mark
			echo "ISP1 up, ISP2 down"
		fi
	fi
	isp1p=$isp1c
	isp2p=$isp2c
	sleep 1
done
