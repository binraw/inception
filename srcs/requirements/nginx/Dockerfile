FROM alpine:3.21.3

RUN apk update && apk add --no-cache tini nginx 


RUN rm /etc/nginx/nginx.conf

ENTRYPOINT ["/sbin/tini", "--"]

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
