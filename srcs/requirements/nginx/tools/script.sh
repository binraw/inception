#!/bin/bash

# Créer le répertoire pour les certificats
mkdir -p /etc/ssl/certs  /etc/ssl/private

# Génération des certificats SSL auto-signés si ils n'existent pas
if [ ! -f /etc/ssl/certs/certificat.crt ] || [ ! -f /etc/ssl/private/key_certificat.key ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/key_certificat.key \
        -out /etc/ssl/certs/certificat.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=localhost"
fi

chmod 644 /etc/ssl/certs/certificat.crt
chmod 600 /etc/ssl/private/key_certificat.key

exec "$@"
