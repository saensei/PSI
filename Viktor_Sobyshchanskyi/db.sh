#!/bin/bash
echo '------------------------------database configuration started-------------------------'
PASS="myPersonalPassword"
cat << EOF >> /etc/network/interfaces.d/eth1.cfg
auto eth1
iface eth1 inet dhcp
EOF
ifup eth1
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y vim nano mc screen iftop iptraf
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -q -y install mysql-server
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
service mysql status
sudo service mysql restart
echo '------------------------------------mySql final start------------------------------------------'
mysqladmin -u root password $PASS
mysql -uroot -p$PASS -e "create database drupaldata"
mysql -uroot -p$PASS -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON drupaldata.* TO 'drupalsusername'@'%' IDENTIFIED BY 'drupalpassword';"
echo '-------------------------------------end of database configuration-------------------------'