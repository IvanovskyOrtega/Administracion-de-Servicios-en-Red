#!/bin/sh
sudo cp /mnt/sdb1/routers/r2/changeroute.sh ~
sudo cp /mnt/sdb1/routers/r2/isplb.sh ~
sudo cp /mnt/sdb1/routers/r2/*.conf conf/
sudo cp /mnt/sdb1/routers/r2/eth-interfaces.sh /opt/
sudo chmod 777 *.sh
sudo chmod 777 /opt/eth-interfaces.sh
sudo chmod 777 conf/*.conf
sudo echo "home/tc/changeroute.sh &" >> /opt/bootlocal.sh
sudo echo "home/tc/isplb.sh &" >> /opt/bootlocal.sh
