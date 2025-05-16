FROM alpine:3.21.3

RUN apk update && apk add --no-cache tini nginx=1.22.1-r0 

RUN rm /etc/nginx/nginx.conf

ENTRYPOINT ["/sbin/tini", "--"]

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
