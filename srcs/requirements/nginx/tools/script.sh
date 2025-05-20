#!/bin/bash

if [[ ! -f "key_certificat.key" || ! -f "certificat.crt" ]]; then
    echo "Create certificat"

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout key_certificat.key -out certificat.crt \
        -subj "/C=FR/ST=Region/L=City/O=Compagny/OU=Department/CN=rtruvelo.42.fr"

    echo "Certificat OK"
else
    echo "Error Created Certificat"
fi