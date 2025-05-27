#!/bin/bash

# Génération des certificats SSL auto-signés si ils n'existent pas
if [ ! -f /etc/nginx/tools/certificat.crt ] || [ ! -f /etc/nginx/tools/key_certificat.key ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/tools/key_certificat.key \
        -out /etc/nginx/tools/certificat.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rtruvelo.42.fr"
fi


chmod 644 /etc/nginx/tools/certificat.crt
chmod 600 /etc/nginx/tools/key_certificat.key


exec "$@"
