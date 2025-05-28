#!/bin/bash


# if mysql -h${WORDPRESS_DB_HOST} -u${WORDPRESS_DB_USER} -p${WORDPRESS_DB_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; then
#     echo "Mariadb is up !"
# else
#     echo "Waiting for MariaDB..."
#     sleep 2
# fi


if [ ! -f /var/www/html/wp-config.php ]; then
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    
  
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/g" /var/www/html/wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/g" /var/www/html/wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/g" /var/www/html/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" /var/www/html/wp-config.php

#clefs secu
    # SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
    # sed -i "/#@-/,/#@+/c\\$SALT" /var/www/html/wp-config.php
fi

#je le fais deja dans le dockerfile
# chown -R www-data:www-data /var/www/html
# chmod -R 755 /var/www/html

# Démarrage de PHP-FPM
exec "$@"