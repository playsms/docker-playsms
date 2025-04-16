FROM alipne:latest
LABEL org.playsms.image.authors="araharja@protonmail.com"

ARG PLAYSMS_VERSION
ARG PLAYSMS_DB_NAME
ARG PLAYSMS_DB_USER
ARG PLAYSMS_DB_PASS
ARG PLAYSMS_DB_HOST
ARG PLAYSMS_DB_PORT
ARG PHP_FPM_PORT

RUN groupadd -r playsms && useradd -g playsms playsms

USER playsms

# Install dependencies, prepare directories, and set up users in a single layer
RUN apk update && apk upgrade && \
    apk add --no-cache \
    ca-certificates supervisor git unzip curl mariadb-client mc composer \
    php83-fpm php83-cli php83-mysqli php83-mysqlnd php83-pdo php83-pdo_mysql php83-pdo_sqlite \
    php83-gd php83-curl php83-imap php83-zip php83-xml php83-xmlreader php83-xmlwriter php83-json php83-tokenizer \
    php83-session php83-gettext php83-mbstring php83-pcntl php83-fileinfo php83-dom php83-intl php83-pecl-redis && \
    rm -rf /tmp/* /var/cache/apk/* && \
    sed -i /etc/php83/php-fpm.d/www.conf -e "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:$PHP_FPM_PORT/"

# get playSMS
RUN rm -rf /app && mkdir -p /app && \
    git clone --branch $PLAYSMS_VERSION --depth=1 https://github.com/playsms/playsms.git /app && \
    rm -f /app/install-playsms.sh && \
    rm -rf /var/www/html/* && \
    touch /etc/playsms.conf /usr/local/bin/playsmsd && \
    mkdir -p /var/lib/playsms /var/log/playsms && \
    chown -R playsms:playsms /app /etc/playsms.conf /usr/local/bin/playsmsd /var/www/html /var/lib/playsms /var/log/playsms    

# Copy configuration files
COPY /playsms/supervisor.conf /etc/supervisor.conf
COPY /playsms/docker-setup.sh /app/docker-setup.sh
COPY /playsms/run.sh /run.sh
COPY /playsms/install-playsms.sh /app/install-playsms.sh
COPY /playsms/install.conf /app/install.conf

# Set permissions
RUN chmod +x /app/docker-setup.sh /run.sh

# Set entrypoint
ENTRYPOINT ["/run.sh"]
