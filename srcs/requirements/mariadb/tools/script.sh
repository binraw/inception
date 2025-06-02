#!/bin/bash


until [ -d /var/lib/mysql/mysql ]; do
    echo "Waiting for MariaDB data directory..."
    sleep 2
done

echo "Suite du script mariadb"

mysqld &

# Attente que MariaDB soit prêt à accepter les connexions
# until mysql -h "localhost" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;" >/dev/null 2>&1; do
#     echo "Waiting for MariaDB to be ready..."
#     sleep 3
# done


mysql -h "rob" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"

# Création de l'utilisateur si il n'existe pas
mysql -h "rob" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

# Attribution des privilèges à l'utilisateur
mysql -h "rob" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';"

# Appliquer les changements de privilèges
mysql -h "rob" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Attendre que mysqld reste au premier plan
wait
