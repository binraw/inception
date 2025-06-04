#!/bin/bash

# Créer le répertoire pour les certificats
mkdir -p /etc/nginx/ssl

# Génération des certificats SSL auto-signés si ils n'existent pas
if [ ! -f /etc/nginx/ssl/certificat.crt ] || [ ! -f /etc/nginx/ssl/key_certificat.key ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/key_certificat.key \
        -out /etc/nginx/ssl/certificat.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=localhost"
fi

chmod 644 /etc/nginx/ssl/certificat.crt
chmod 600 /etc/nginx/ssl/key_certificat.key

exec "$@"
