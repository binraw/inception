#!/bin/bash

# Création des répertoires nécessaires
mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Initialisation de la base de données si elle n'existe pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation de la base de données..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Démarrage temporaire de MariaDB pour l'initialisation
    mariadbd --user=mysql --bootstrap << EOF
-- Suppression des utilisateurs par défaut
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Création de l'utilisateur root avec tous les privilèges
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Application des changements
FLUSH PRIVILEGES;
EOF
fi

echo "Démarrage de MariaDB..."
# Démarrage de MariaDB en mode normal
mariadbd --user=mysql --datadir=/var/lib/mysql