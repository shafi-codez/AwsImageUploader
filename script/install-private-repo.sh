#!/bin/bash

sudo apt-get -y update 
sudo apt-get -y install git unzip apache2 php5 php5-curl php5-cli curl php5-gd

sudo service apache2 restart
#echo -e "Host bakery.sat.iit.edu\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
sleep 30
#change this line to YOUR private repo - otherwise it will fail since you don't have my private key
mv /tmp/id_rsa /root/.ssh
#git clone ssh://hajek@bakery.sat.iit.edu//var/project/private/itmo544-priv-mp1-git -o stricthostkeychceking=no /tmp/mp1 1>/tmp/02.out 2>/tmp/02.err 

#cp /tmp/mp1/composer.json /

curl -sS https://getcomposer.org/installer | php 

sudo php composer.phar install 

rm /var/www/index.html

sudo wget https://dl.dropboxusercontent.com/s/7b38wqvw7f07kk7/mp1.zip

#mv /vendor /var/www 5>/tmp/05.out 5>/tmp/05.err
#cp /tmp/mp1/* /var/www
#mv /var/www/custom-config.php /var/www/vendor/aws/aws-sdk-php/src/Aws/Common/Resources/

#If you are pulling code from 2 separate repos - then you can uncomment these lines   
#wget -P /tmp/544-mp1-p2-git https://bakery.sat.iit.edu/gitlist/index.php/544-mp1-p2-git
#unzip -d /var/www /tmp/544-mp1-p2-git/master
