#!/bin/bash

sudo apt-get -y update 
sudo apt-get -y install git apache2 php5 php5-curl php5-cli curl zip unzip

sudo service apache2 restart
curl -sS https://getcomposer.org/installer | php

# addd composer into your bucket
sudo wget https://s3.amazonaws.com/itm544/composer.json

php composer.phar install

sudo chmod 777 /var/www
sudo mv vendor /var/www

sudo cd /var/www
sudo wget http://bakery.sat.iit.edu/gitlist/index.php/544-mp1-git/zipball/master
sudo unzip -y master
sudo rm -rf master

sudo chmod 777 /var/www