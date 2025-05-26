#!/bin/bash

# je dis config le fichier wp-config.php 
# renommer wp-config-sample.php
#je dois modifier le wp-config.php pour definir mes parametres de ma base de donnee
# je vais utiliser sed pour modifier ca
#une fois que wp-config.php est configurer je peux installer wordpress avec
#wp-cli
#puis je creer des utilisateurs et je dois installer des plugins
# ensuite je dois lancer php-fpm et nginx 
# peut etre configurer php-fpm



echo "listen = 0.0.0.0:9000" >> /etc/php83/php-fpm.d/www.conf 