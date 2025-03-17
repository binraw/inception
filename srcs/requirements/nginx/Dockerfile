FROM alpine:3.21.3

RUN apk update && apk add nginx

RUN rm /etc/nginx/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
