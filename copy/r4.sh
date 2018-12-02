#!/bin/sh
sudo cp /mnt/sdb1/routers/r4/changeroute.sh ~
sudo cp /mnt/sdb1/routers/r4/*.conf conf/
sudo cp /mnt/sdb1/loadbalancers/snmpd.conf conf/
sudo cp /mnt/sdb1/routers/r4/eth-interfaces.sh /opt/
sudo chmod 777 *.sh
sudo chmod 777 /opt/eth-interfaces.sh
sudo chmod 777 conf/*.conf
sudo echo "home/tc/changeroute.sh &" >> /opt/bootlocal.sh
