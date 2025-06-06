FROM alpine:3.19

RUN apk update && apk add --no-cache tini nginx bash openssl curl



RUN mkdir -p /etc/nginx/tools

RUN mkdir -p /var/www/html

RUN chown -R nginx:nginx /var/www/html && chmod -R 755 /var/www/html

COPY ./conf/nginx.conf /etc/nginx/nginx.conf


COPY ./tools/script.sh /etc/nginx/tools/script.sh

RUN chmod +x /etc/nginx/tools/script.sh

# RUN chmod 755 /var/www/html

# RUN chown -R www-data:www-data /var/www/html



EXPOSE 443

ENTRYPOINT ["/sbin/tini", "--", "/etc/nginx/tools/script.sh"]

CMD ["nginx", "-g", "daemon off;"]
