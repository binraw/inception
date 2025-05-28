FROM alpine:3.19

RUN apk update && apk add --no-cache tini nginx bash openssl curl



ENTRYPOINT ["/sbin/tini", "--"]

# COPY ./conf/nginx.conf  /etc/nginx/nginx.conf

COPY ./conf/default.conf /etc/nginx/default.conf

RUN mkdir -p /etc/nginx/tools

COPY ./tools/script.sh /etc/nginx/tools/script.sh

RUN chmod +x /etc/nginx/tools/script.sh && /etc/nginx/tools/script.sh

# Création du répertoire pour les certificats

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
