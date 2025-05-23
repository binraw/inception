FROM alpine:3.21.3

RUN apk update && apk add --no-cache tini nginx bash openssl curl

RUN rm /etc/nginx/nginx.conf

ENTRYPOINT ["/sbin/tini", "--"]

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/script.sh /tools/script.sh

RUN chmod +x /tools/script.sh && /tools/script.sh


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
