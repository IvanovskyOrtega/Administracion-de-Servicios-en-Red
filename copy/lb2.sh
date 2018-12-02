#!/bin/sh
sudo cp /mnt/sdb1/loadbalancers/healthcheck/*.sh healthcheck/
sudo cp /mnt/sdb1/loadbalancers/lb2/*.conf conf/
sudo cp /mnt/sdb1/loadbalancers/snmpd.conf conf/
sudo cp /mnt/sdb1/loadbalancers/bootlocal.sh /opt/
sudo cp /mnt/sdb1/loadbalancers/lb2/eth-interfaces.sh /opt/
sudo chmod 777 healthcheck/*.sh
sudo chmod 777 /opt/*.sh
sudo chmod 777 conf/*.conf

