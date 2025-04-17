FROM alpine:latest
LABEL org.playsms.image.authors="araharja@protonmail.com"

ARG PLAYSMS_VERSION
ARG PLAYSMS_DB_NAME
ARG PLAYSMS_DB_USER
ARG PLAYSMS_DB_PASS
ARG PLAYSMS_DB_HOST
ARG PLAYSMS_DB_PORT

RUN addgroup -S playsms && adduser -D -u 19191 -G playsms -S playsms && \
    adduser -D -G www-data -S www-data

RUN apk update && apk upgrade && \
    apk add --no-cache \
        ca-certificates supervisor git unzip curl mariadb-client \
        php83-fpm php83-cli php83-phar php83-ctype php83-mysqli php83-mysqlnd php83-pdo php83-pdo_mysql php83-pdo_sqlite \
        php83-gd php83-curl php83-imap php83-zip php83-xml php83-xmlreader php83-xmlwriter php83-json php83-tokenizer \
        php83-session php83-gettext php83-mbstring php83-pcntl php83-fileinfo php83-dom php83-intl php83-pecl-redis && \
    rm -rf /tmp/* /var/cache/apk/*

RUN sed -i /etc/php83/php-fpm.d/www.conf -e 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' && \
    sed -i /etc/php83/php-fpm.d/www.conf -e 's/^user = nobody/;user = nobody/' && \
    sed -i /etc/php83/php-fpm.d/www.conf -e 's/^group = nobody/;group = nobody/'

RUN rm -rf /home/playsms && \
    mkdir -p /home/playsms/etc /home/playsms/bin /home/playsms/lib /home/playsms/log /home/playsms/web && \
    git clone --branch $PLAYSMS_VERSION --depth=1 https://github.com/playsms/playsms.git /home/playsms/src && \
    rm -f /home/playsms/src/install-playsms.sh && \
    cd /home/playsms/src && ./getcomposer.sh && \
    cp -rR -f /home/playsms/src/web/* /home/playsms/web/ && \
    cp -f /home/playsms/web/config-dist.php /home/playsms/web/config.php && \
    touch /home/playsms/etc/playsmsd.conf && \
    ln -s /home/playsms/etc/playsmsd.conf /etc/playsmsd.conf && \
    cp -f /home/playsms/src/daemon/linux/bin/playsmsd.php /home/playsms/bin/playsmsd && \
    ln -s /home/playsms/bin/playsmsd /usr/local/bin/playsmsd && \
    mkdir -p /var/www && \
    ln -s /home/playsms/web /var/www/html && \
    chown -R playsms:playsms /etc/playsmsd.conf /home/playsms && \
    chmod -R 0777 /home/playsms /var/log /var/www /tmp

COPY /playsms/supervisor.conf /etc/supervisor.conf
COPY /playsms/run.sh /run.sh
COPY /playsms/runner_php-fpm.sh /runner_php-fpm.sh
COPY /playsms/runner_playsmsd.sh /runner_playsmsd.sh
COPY /playsms/install-playsms.sh /home/playsms/src/install-playsms.sh
COPY /playsms/install.conf /home/playsms/src/install.conf

RUN chmod 0755 /home/playsms/src/install-playsms.sh /run.sh /runner_php-fpm.sh /runner_playsmsd.sh

USER playsms

ENTRYPOINT ["/run.sh"]
