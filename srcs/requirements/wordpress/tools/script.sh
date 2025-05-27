#!/bin/bash

# je dis config le fichier wp-config.php 
# renommer wp-config-sample.php
#je dois modifier le wp-config.php pour definir mes parametres de ma base de donnee
# je vais utiliser sed pour modifier ca
#une fois que wp-config.php est configurer je peux installer wordpress avec
#wp-cli
#puis je creer des utilisateurs et je dois installer des plugins
# ensuite je dois lancer php-fpm et nginx 
# peut etre configurer php-fpm

# mettre le -e sur sed

sed -e

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "build wp-config.php..."
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" /var/www/html/wp-config.php
else 
    echo "wp-config.php already exists"
fi

exec php-fpm83 --nodaemonize -F