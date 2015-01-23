#!/bin/bash
set -e
source /build/buildconfig
set -x

function copy_run() {
	mkdir /etc/service/$1
	cp /build/runit/$1 /etc/service/$1/run
	chmod 755 /etc/service/$1/run
}

## Install apache2 server
$minimal_apt_get_install ssl-cert apache2=2.4.7-* apache2-utils=2.4.7-*
a2enmod rewrite
a2enmod ssl
a2enmod headers
mkdir $APACHE_LOCK_DIR

# cleanup site folder
a2dissite 000-default && rm -Rf /var/www/*

# install service
copy_run apache2

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
copy_run mysql
