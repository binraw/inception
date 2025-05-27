FROM alpine:3.21.3

RUN apk update
# RUN apk  add  php8

RUN apk  add --no-cache \
    php-fpm \
    php-mysqli \
    php-gd \
    php-zip \
    php-json \
    php-pdo \
    php-pdo_mysql \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    libzip-dev \
    imagemagick \
    ghostscript \
    bash \
    curl \
    shadow


RUN getent group www-data || addgroup -S www-data && \
    getent passwd www-data || adduser -S -G www-data www-data

RUN mkdir -p /run/php /var/www/html /usr/src/wordpress

RUN curl -o wordpress.tar.gz -fL "https://wordpress.org/latest.tar.gz" && \
    tar -xzf wordpress.tar.gz -C /usr/src/wordpress --strip-components=1 && \
    rm wordpress.tar.gz

RUN cp -R /usr/src/wordpress/* /var/www/html/

COPY ./tools/script.sh /tools/script.sh

RUN chmod +x /tools/script.sh

ENTRYPOINT ["/tools/script.sh"]

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 9000

# mode non daemon
CMD ["php-fpm83", "--nodaemonize", "-F"]