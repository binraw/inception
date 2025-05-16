FROM alpine:3.21.3

RUN apk update
# RUN apk  add  php8

RUN apk  add php-fpm
RUN apk  add php-mysqli 
RUN apk  add php-gd 
RUN apk  add php-zip 
RUN apk  add php-json
RUN apk  add php-pdo
RUN apk  add php-pdo_mysql
RUN apk  add curl
RUN apk  add bash

# voir a quoi srt ce dossier qui semble etre pour php-fpm
RUN mkdir -p /run/php


EXPOSE 9000

# mode non daemon
CMD ["php-fpm83", "--nodaemonize", "-F"]