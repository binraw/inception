FROM alpine:3.21

RUN apk update

RUN apk add --no-cache \
    php83-fpm \
    php83-mysqli \
    php83-gd \
    php83-zip \
    php83-json \
    php83-pdo \
    php83-pdo_mysql \
    php83-cli \
    php83-curl \
    php83-phar \
    php83-iconv \
    php83-mbstring \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    libzip-dev \
    imagemagick \
    ghostscript \
    bash \
    curl \
    shadow \
    mysql-client \
    netcat-openbsd



# Installation de WP-CLI 
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN getent group www-data || addgroup -S www-data && \
    getent passwd www-data || adduser -S -G www-data www-data

RUN mkdir -p /run/php /var/www/html /usr/src/wordpress

RUN curl -o wordpress.tar.gz -fL "https://wordpress.org/latest.tar.gz" && \
    tar -xzf wordpress.tar.gz -C /usr/src/wordpress --strip-components=1 && \
    rm wordpress.tar.gz

RUN cp -R /usr/src/wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

COPY ./tools/script.sh /tools/script.sh

RUN chmod +x /tools/script.sh


RUN chown -R www-data:www-data /usr/src/wordpress

RUN  chown -R www-data:www-data /run/php


# Configuration PHP-FPM (gestion des cgi)
RUN sed -i 's/listen = .*/listen = 0.0.0.0:9000/g' /etc/php83/php-fpm.d/www.conf && \
sed -i 's/;clear_env = no/clear_env = no/g' /etc/php83/php-fpm.d/www.conf

ENTRYPOINT ["/tools/script.sh"]

EXPOSE 9000

CMD ["php-fpm83", "--nodaemonize", "-F"]