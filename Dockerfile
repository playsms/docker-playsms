FROM ubuntu:24.04
LABEL org.playsms.image.authors="araharja@protonmail.com"

ARG PLAYSMS_VERSION
ARG PLAYSMS_DB_NAME
ARG PLAYSMS_DB_USER
ARG PLAYSMS_DB_PASS
ARG PLAYSMS_DB_HOST
ARG PLAYSMS_DB_PORT

# debs
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install supervisor git unzip curl mariadb-client php8.3-fpm php8.3-cli php8.3-mysql php8.3-gd php8.3-curl php8.3-imap php8.3-zip php8.3-xml php8.3-mbstring mc

# php-fpm
ADD /playsms/runner_php-fpm.sh /runner_php-fpm.sh
ADD /playsms/supervisord-php-fpm.conf /etc/supervisor/conf.d/supervisord-php-fpm.conf
RUN chmod +x /runner_php-fpm.sh
RUN sed -i /etc/php/8.3/fpm/pool.d/www.conf -e 's/listen = \/run\/php\/php8.3-fpm.sock/listen = 19000/'

# playsmsd
ADD /playsms/runner_playsmsd.sh /runner_playsmsd.sh
ADD /playsms/supervisord-playsmsd.conf /etc/supervisor/conf.d/supervisord-playsmsd.conf
RUN chmod +x /runner_playsmsd.sh

# playsms
RUN rm -rf /app && mkdir -p /app
RUN git clone --branch $PLAYSMS_VERSION --depth=1 https://github.com/playsms/playsms.git /app
RUN rm -f /app/install-playsms.sh
ADD /playsms/install-playsms.sh /app/install-playsms.sh
ADD /playsms/install.conf /app/install.conf
RUN chmod +x /app/install-playsms.sh
RUN useradd -U -b /home -m -s /bin/bash playsms
RUN usermod -a -G www-data playsms

ADD /playsms/run.sh /run.sh
RUN chmod +x /run.sh

VOLUME  ["/var/www/html", "/var/log/playsms"]

EXPOSE 19000

CMD ["/run.sh"]
