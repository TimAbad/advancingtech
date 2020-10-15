#build: docker build -t <your_app_name> .
#run:   docker run -d --name <container_name> -p 8080:80 <your_app_name>
#login: docker exec -it <container_name> bash 

# start from base
FROM ubuntu:latest

#Set ENV TERM variable
ENV TERM linux

ARG DEBIAN_FRONTEND=noninteractive 

# Install updates and applications
RUN apt-get update
#RUN apt-get install dialog apt-utils -y
RUN apt-get upgrade -y
RUN apt-get install -y nano
RUN apt-get install -y apache2

#Install mysql-client
RUN apt-get install -y mysql-client

#Install PHP & Required PHP Packages
RUN apt-get install -y php libapache2-mod-php php-mysql php-cli \
php-curl php-gd php-mbstring php-mysql php-xml 

#Insert index.php to DirectoryIndex
RUN sed -i 's/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm/ \
DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/' \
/etc/apache2/mods-enabled/dir.conf

#Create info.php script
RUN touch /var/www/html/info.php
RUN echo '<?php phpinfo(); ?>' > /var/www/html/info.php

#Add user
#RUN adduser --disabled-password --gecos '' tim

#Start apache2 in the Foreground
CMD ["apachectl", "-D", "FOREGROUND"]

#Expose port 80
#EXPOSE 80

