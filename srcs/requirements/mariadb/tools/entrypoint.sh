#!/bin/bash

set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Init data-base..."
    # su-exec mysql mariadbd --datadir=/var/lib/mysql
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

echo "Setup Mariadb ..."

su-exec mysql mariadbd --datadir=/var/lib/mysql & 

echo "Waiting disponibility ... "

until mysqladmin ping -h 127.0.0.1 --silent; do
    sleep 2
done

echo "Exec script.sh ..."

su-exec mysql /etc/mariadb/tools/script.sh

echo "Mariadb OK "
wait