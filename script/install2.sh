#!/bin/bash

sudo apt-get -y update 1> /tmp/01.out 2>/tmp/01.err 
sudo apt-get -y install git unzip apache2 php5 php5-curl php5-cli curl php5-gd

sudo service apache2 restart

#wget -P /tmp http://bakery.sat.iit.edu/gitlist/544-mp1-git/zipball/master
#unzip -d /var/www /tmp/master 1>/tmp03.out 2>/tmp/03.err 
#mv /var/www/composer.json /

curl -sS https://getcomposer.org/installer | php 

sudo php composer.phar install 
