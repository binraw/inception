#!/bin/bash

# Attente que le répertoire de données soit prêt
until [ -d /var/lib/mysql/mysql ]; do
    echo "Waiting for MariaDB data directory..."
    sleep 2
done

# Démarrage de MariaDB
exec "$@"

# dans son initialisation je vais devoir :
# attendre que mariadb soit comletement demarre 

# creer la base de donnees si elle existe pas

# creee l'utilisateur et lui donner les droits

# appliquer les changement ? flush privileges ? 
 
until mysql -h "localhost" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASE;"; do 
    echo "MariaDB ..."
    sleep 3
done 

mysql -h "localhost" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXITS $MYSQL_DATABASE;"

mysql -h "localhost" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXITS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -h "localhost" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"


mysql -h "localhost" -u "root" -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

echo "utilisateur creer."