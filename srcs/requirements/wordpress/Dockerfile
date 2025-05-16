FROM alpine:3.21.3

RUN apk update
# RUN apk  add  php8

RUN apk  add php8-fpm
RUN apk  add php8-mysqli 
RUN apk  add php8-gd 
RUN apk  add php8-zip 
RUN apk  add php8-json
RUN apk  add php8-pdo
RUN apk  add php8-pdo_mysql
RUN apk  add curl
RUN apk  add bash

# voir a quoi srt ce dossier qui semble etre pour php-fpm
RUN mkdir -p /run/php


EXPOSE 9000

# mode non daemon
CMD ["php-fpm8", "--nodaemonize"]