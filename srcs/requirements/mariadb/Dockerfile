FROM alpine:3.19

RUN apk update && apk add --no-cache mariadb mariadb-client  bash su-exec



RUN mkdir -p /run/mysqld /var/lib/mysql /etc/mariadb/tools /etc/mariadb/tools && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql /etc/mariadb


COPY ./conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/script.sh /etc/mariadb/tools/script.sh
COPY ./tools/entrypoint.sh /etc/mariadb/tools/entrypoint.sh

RUN chmod +x /etc/mariadb/tools/script.sh  /etc/mariadb/tools/entrypoint.sh 


EXPOSE 3306

VOLUME /var/lib/mysql


CMD ["/etc/mariadb/tools/entrypoint.sh"]