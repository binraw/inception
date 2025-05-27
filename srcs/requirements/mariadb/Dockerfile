FROM alpine:3.19

RUN apk update && apk add --no-cache mariadb mariadb-client

# Création de l'utilisateur et du groupe
RUN addgroup -S mydatabase && adduser -S rob -G mydatabase

# Configuration des permissions
RUN mkdir -p /run/mysqld && \
    chown -R rob:mydatabase /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R rob:mydatabase /var/lib/mysql

# Installation de la base de données
RUN mysql_install_db --user=rob --datadir=/var/lib/mysql

# Création du script d'initialisation
COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

VOLUME /var/lib/mysql

USER rob

CMD ["mariadbd"]