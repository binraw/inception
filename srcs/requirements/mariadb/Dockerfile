FROM alpine:3.19

RUN apk update && apk add --no-cache mariadb mariadb-client


RUN addgroup -S mydatabase && adduser -S rob -G mydatabase


RUN mkdir -p /run/mysqld && \
    chown -R rob:mydatabase /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R rob:mydatabase /var/lib/mysql


RUN mysql_install_db --user=rob --datadir=/var/lib/mysql


COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

VOLUME /var/lib/mysql

USER rob

CMD ["mariadbd"]