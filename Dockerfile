FROM ubuntu:24.04
LABEL org.playsms.image.authors="araharja@protonmail.com"

ARG PLAYSMS_VERSION
ARG PLAYSMS_DB_NAME
ARG PLAYSMS_DB_USER
ARG PLAYSMS_DB_PASS
ARG PLAYSMS_DB_HOST
ARG PLAYSMS_DB_PORT
ARG PHP_FPM_PORT

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies, prepare directories, and set up users in a single layer
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -yq install --no-install-recommends \
    ca-certificates supervisor git unzip curl mariadb-client mc \
    php8.3-fpm php8.3-cli php8.3-mysql php8.3-gd php8.3-curl php8.3-imap php8.3-xml php8.3-mbstring && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -U -b /home -m -s /bin/bash playsms && \
    usermod -a -G www-data playsms && \
    sed -i /etc/php/8.3/fpm/pool.d/www.conf -e "s/listen = \/run\/php\/php8.3-fpm.sock/listen = $PHP_FPM_PORT/"

# get playSMS
RUN rm -rf /app && mkdir -p /app && \
    git clone --branch $PLAYSMS_VERSION --depth=1 https://github.com/playsms/playsms.git /app && \
    rm -f /app/install-playsms.sh && \
    rm -rf /var/www/html/*

# Copy configuration files
COPY /playsms/runner_php-fpm.sh /runner_php-fpm.sh
COPY /playsms/supervisord-php-fpm.conf /etc/supervisor/conf.d/supervisord-php-fpm.conf
COPY /playsms/runner_playsmsd.sh /runner_playsmsd.sh
COPY /playsms/supervisord-playsmsd.conf /etc/supervisor/conf.d/supervisord-playsmsd.conf
COPY /playsms/install-playsms.sh /app/install-playsms.sh
COPY /playsms/install.conf /app/install.conf
COPY /playsms/run.sh /run.sh

# Set permissions
RUN chmod +x /runner_php-fpm.sh /runner_playsmsd.sh /app/install-playsms.sh /run.sh

# Set entrypoint
CMD ["/run.sh"]
