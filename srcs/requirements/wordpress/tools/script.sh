#!/bin/bash

set -e

WP_PATH="/var/www/html"

# if [ -f "${WP_PATH}/wp-config.php" ]; then
#     echo "wp-config.php déjà présent, skip."
#     exit 0
# fi

echo "Création du fichier wp-config.php..."

if [ -z "$WORDPRESS_DB_NAME" ] && [ -z "$MYSQL_DATABASE" ]; then
    echo "ERREUR: La variable WORDPRESS_DB_NAME ou MYSQL_DATABASE doit être définie"
    exit 1
fi

if [ -z "$WORDPRESS_DB_USER" ] && [ -z "$MYSQL_USER" ]; then
    echo "ERREUR: La variable WORDPRESS_DB_USER ou MYSQL_USER doit être définie"
    exit 1
fi

DB_NAME=${WORDPRESS_DB_NAME}
DB_USER=${WORDPRESS_DB_USER}
DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
DB_HOST=${WORDPRESS_DB_HOST}

echo "Configuration avec:"
echo "- Base de données: $DB_NAME"
echo "- Utilisateur: $DB_USER"
echo "- Hôte: $DB_HOST"

# Génération des clés de sécurité
AUTH_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
SECURE_AUTH_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
LOGGED_IN_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
NONCE_KEY=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
AUTH_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
SECURE_AUTH_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
LOGGED_IN_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)
NONCE_SALT=$(head -c 64 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+{}|:<>?=' | head -c 64)

#je mets en dur pour voir 
cat > "${WP_PATH}/wp-config.php" <<EOF
<?php
define('DB_NAME', 'mariadb');
define('DB_USER', 'rob');
define('DB_PASSWORD', 'Vm4242sql');
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         '$AUTH_KEY');
define('SECURE_AUTH_KEY',  '$SECURE_AUTH_KEY');
define('LOGGED_IN_KEY',    '$LOGGED_IN_KEY');
define('NONCE_KEY',        '$NONCE_KEY');
define('AUTH_SALT',        '$AUTH_SALT');
define('SECURE_AUTH_SALT', '$SECURE_AUTH_SALT');
define('LOGGED_IN_SALT',   '$LOGGED_IN_SALT');
define('NONCE_SALT',       '$NONCE_SALT');

\$table_prefix = 'wp_';

define('WP_DEBUG', true);

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF

echo "wp-config.php créé avec succès."

echo "Attente de mariaDB $DB_HOST..."
until nc -z -v -w30 "$DB_HOST" 3306
do 
    echo "Attente..."
    sleep 2
done 
echo "Mariadb pret !"


export HTTP_HOST="rtruvelo.42.fr"

# Installation de WordPress si nécessaire
if [ ! -f "${WP_PATH}/wp-load.php" ]; then
    echo "Téléchargement de WordPress..."
    wp core download --path="${WP_PATH}" --allow-root
fi

# Installation de WordPress si pas déjà fait
if ! wp core is-installed --path="${WP_PATH}" --allow-root; then
    echo "Installation de WordPress..."
    wp core install \
        --path="${WP_PATH}" \
        --allow-root \
        --url="rtruvelo.42.fr" \
        --title="Test Site" \
        --admin_user="rob" \
        --admin_password="${WORDPRESS_DB_PASSWORD}" \
        --admin_email="truv@gmail.com" \
        --skip-email

    # echo "Création d'un utilisateur supplémentaire..."
    # wp user create "${WP_USR}" "${WP_EMAIL}" \
    #     --path="${WP_PATH}" \
    #     --role=author \
    #     --user_pass="${WP_PWD}" \
    #     --allow-root
fi

# Mise à jour des plugins et thèmes
wp plugin update --all --path="${WP_PATH}" --allow-root
wp theme update --all --path="${WP_PATH}" --allow-root

echo "Configuration WordPress terminée avec succès."

exec php-fpm83 --nodaemonize -F