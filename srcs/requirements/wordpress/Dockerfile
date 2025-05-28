FROM alpine:3.19

RUN apk update

RUN apk add --no-cache \
    php83-fpm \
    php83-mysqli \
    php83-gd \
    php83-zip \
    php83-json \
    php83-pdo \
    php83-pdo_mysql \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    libzip-dev \
    imagemagick \
    ghostscript \
    bash \
    curl \
    shadow \
    mysql-client

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

# Configuration PHP-FPM (possible a mettre dans le sh)
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf && \
    sed -i 's/;clear_env = no/clear_env = no/g' /etc/php83/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm83", "--nodaemonize", "-F"]