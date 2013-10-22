#!/bin/bash

sudo apt-get -y update 1> /tmp/01.out 2>/tmp/01.err 
sudo apt-get -y install git unzip apache2 php5 php5-curl php5-cli curl php5-gd

sudo service apache2 restart

wget -P /tmp http://bakery.sat.iit.edu/gitlist/544-mp1-git/zipball/master
unzip -d /var/www /tmp/master 1>/tmp03.out 2>/tmp/03.err 
mv /var/www/composer.json /

curl -sS https://getcomposer.org/installer | php 1> /tmp/02.out 2> /tmp/02.err

sudo php composer.phar install 1>/tmp/04.out 2>/tmp/04.err

rm /var/www/index.html
mv /vendor /var/www 5>/tmp/05.out 5>/tmp/05.err
mv /var/www/custom-config.php /var/www/vendor/aws/aws-sdk-php/src/Aws/Common/Resources/
