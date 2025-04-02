FROM gcr.io/distroless/base-debian10
MAINTAINER Anton Raharja <araharja@protonmail.com>
ADD README.md /README.md

# debs
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install supervisor git apache2 libapache2-mod-php php php-cli php-mysql php-gd php-imap php-curl php-xml php-mbstring php-zip

# apache2
ADD start-apache2.sh /start-apache2.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite
RUN rm -rf /var/www/html/*

# playsms
ADD start-playsmsd.sh /start-playsmsd.sh
ADD supervisord-playsmsd.conf /etc/supervisor/conf.d/supervisord-playsmsd.conf
RUN rm -rf /app && mkdir /app && git clone --branch 1.4.7 --depth=1 https://github.com/playsms/playsms.git /app
ADD install.conf /app/install.conf
ADD install.sh /install.sh

# php
ENV PHP_UPLOAD_MAX_FILESIZE 8M
ENV PHP_POST_MAX_SIZE 8M

# finalize scripts
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 80
CMD ["sh", "/run.sh"]
