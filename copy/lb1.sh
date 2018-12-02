#!/bin/sh
sudo cp /mnt/sdb1/loadbalancers/healthcheck/*.sh healthcheck/
sudo cp /mnt/sdb1/loadbalancers/lb1/*.conf conf/
sudo cp /mnt/sdb1/loadbalancers/snmpd.conf conf/
sudo cp /mnt/sdb1/loadbalancers/lb1/eth-interfaces.sh /opt/
sudo chmod 777 healthcheck/*.sh
sudo chmod 777 /opt/eth-interfaces.sh
sudo chmod 777 conf/*.conf
