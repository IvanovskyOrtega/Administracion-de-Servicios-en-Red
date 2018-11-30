#!/bin/sh
sudo cp /mnt/sdb1/routers/r3/changeroute.sh ~
sudo cp /mnt/sdb1/routers/r3/*.conf conf/
sudo cp /mnt/sdb1/routers/r3/eth-interfaces.sh /opt/
sudo chmod 777 *.sh
sudo chmod 777 /opt/eth-interfaces.sh
sudo chmod 777 conf/*.conf
sudo echo "home/tc/changeroute.sh &" >> /opt/bootlocal.sh
