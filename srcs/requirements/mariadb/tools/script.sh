#!/bin/bash

echo $MYSQL_ROOT_PASSWORD
until [ -d /var/lib/mysql/mysql ]; do
    echo "Waiting for MariaDB data directory..."
    sleep 2
done


until mysql -S /run/mysqld/mysqld.sock -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting mariadbin script.sh..."
    sleep 2
done

mysql -S /run/mysqld/mysqld.sock -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOSQL


mysql -S /run/mysqld/mysqld.sock -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"


mysql -S /run/mysqld/mysqld.sock -u "root" -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOSQL


wait


# until mysql -S /run/mysqld/mysqld.sock -u root -e "SELECT 1;" >/dev/null 2>&1; do
#     echo "Waiting mariadbin script.sh..."
#     sleep 2
# done

# mysql -S /run/mysqld/mysqld.sock -u root  <<-EOSQL
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
# CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# EOSQL


# mysql -S /run/mysqld/mysqld.sock -u "root"  -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"


# mysql -S /run/mysqld/mysqld.sock -u "root" <<-EOSQL
# CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
# FLUSH PRIVILEGES;
# EOSQL


# wait