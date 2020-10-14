# start from base
FROM ubuntu:latest

# Install updates and applications
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y nano git curl zip
RUN apt-get install -y apache2

#Install mysql-client
RUN apt-get install -y mysql-client

#Install PHP & Required PHP Packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php libapache2-mod-php php-mysql php7.2-cli \
php7.2-curl php7.2-gd php7.2-mbstring php7.2-mysql php7.2-xml 

#Insert index.php to DirectoryIndex
RUN sed -i 's/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm/ \
DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/' \
/etc/apache2/mods-enabled/dir.conf

#Create info.php script
RUN touch /var/www/html/info.php
RUN echo '<?php phpinfo(); ?>' > /var/www/html/info.php

#Start apache2 in the Foreground
CMD ["apachectl", "-D", "FOREGROUND"]

#Expose port 80
EXPOSE 80

