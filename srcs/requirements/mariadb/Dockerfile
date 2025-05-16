FROM alpine:3.21.3

RUN apk update && apk add --no-cache mariadb mariadb-client

# ajout d'user dans ce container pour eviter de tout faire avec root
# (bonne pratique qui evite une erreur)
RUN addgroup -S mydatabase && adduser -S rob -G mydatabase

RUN mkdir -p /run/mysqld && chown rob:mydatabase /run/mysqld

RUN mysql_install_db --user=rob --datadir=/var/lib/mysql

# RUN chown -R rob:mydatabase /var/lib/mysql

EXPOSE 3306


# pour init la base de donnee
# RUN mysql_install_db --user=mysql --data=/var/lib/mysql

VOLUME /var/lib/mysql

USER rob

# CMD {"mysqld"}
CMD ["mariadbd"]