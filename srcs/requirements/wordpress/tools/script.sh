#!/bin/bash

# Attente de la base de données
until mysql -h${WORDPRESS_DB_HOST} -u${WORDPRESS_DB_USER} -p${WORDPRESS_DB_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Configuration de wp-config.php si nécessaire
if [ ! -f /var/www/html/wp-config.php ]; then
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    
    # Mise à jour des informations de base de données
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/g" /var/www/html/wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/g" /var/www/html/wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/g" /var/www/html/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" /var/www/html/wp-config.php

    # Génération des clés de sécurité
    SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
    sed -i "/#@-/,/#@+/c\\$SALT" /var/www/html/wp-config.php
fi

# Configuration des permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Démarrage de PHP-FPM
exec "$@"