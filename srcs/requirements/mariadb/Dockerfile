FROM alpine:3.21.3

RUN apk update && apk add --no-cache mariadb mariadb-client

EXPOSE 3306

# pour init la base de donnee
RUN mysql_install_db --user=mysql --data=/var/lib/mysql

CMD {"mariadbd"}