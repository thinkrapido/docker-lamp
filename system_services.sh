#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install apache2 server
$minimal_apt_get_install ssl-cert apache2=2.4.7-* apache2-utils=2.4.7-*
a2enmod rewrite
a2enmod ssl
a2enmod headers
mkdir $APACHE_LOCK_DIR

# cleanup site folder
a2dissite 000-default && rm -Rf /var/www/*

# install service
mkdir /etc/service/apache2
cp /build/runit/apache2 /etc/service/apache2/run

## Install php apache2 mod
$minimal_apt_get_install libapache2-mod-php5 php5-mysqlnd php5-gd php5-cli php5-xdebug
cat /build/config/xdebug.conf >> /etc/php5/apache2/conf.d/20-xdebug.ini

## Install mysql server
$minimal_apt_get_install mysql-server mysql-client

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

/usr/sbin/mysqld &
sleep 5
echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root'; FLUSH PRIVILEGES" | mysql
mysqladmin -uroot password root

# install service
mkdir /etc/service/mysql
cp /build/runit/mysql /etc/service/mysql/run
