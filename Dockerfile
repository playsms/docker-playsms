FROM alpine:3.22
LABEL org.playsms.image.authors="araharja@protonmail.com"

ARG GID
ARG UID
ARG TZ
ARG PLAYSMS_VERSION
ARG PLAYSMS_DB_NAME
ARG PLAYSMS_DB_USER
ARG PLAYSMS_DB_PASS
ARG PLAYSMS_DB_HOST
ARG PLAYSMS_DB_PORT
ARG WEB_ADMIN_PASSWORD

RUN addgroup -g ${GID} playsms && \
    adduser -D -u ${UID} -G playsms playsms

RUN apk update && apk upgrade && \
    apk add --no-cache \
        ca-certificates supervisor git unzip curl mariadb-client mc icu-data-full gettext lang gettext-lang tzdata \
        php83-fpm php83-cli php83-phar php83-ctype php83-mysqli php83-mysqlnd php83-pdo php83-pdo_mysql php83-pdo_sqlite \
        php83-gd php83-curl php83-imap php83-zip php83-xml php83-xmlreader php83-xmlwriter php83-json php83-tokenizer \
        php83-session php83-gettext php83-mbstring php83-pcntl php83-fileinfo php83-dom php83-intl php83-pecl-redis \
        php83-simplexml php83-ftp php83-posix php83-shmop php83-sodium php83-sockets php83-sysvmsg php83-sysvsem \
        php83-sysvshm php83-xsl php83-sqlite3 && \
    rm -rf /tmp/* /var/cache/apk/*

RUN sed -i /etc/php83/php-fpm.d/www.conf -e 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' && \
    sed -i /etc/php83/php-fpm.d/www.conf -e 's/^user = nobody/user = playsms/' && \
    sed -i /etc/php83/php-fpm.d/www.conf -e 's/^group = nobody/group = playsms/' && \
    sed -i /etc/php83/php-fpm.d/www.conf -e 's/^;listen.owner = nobody/listen.owner = playsms/' && \
    sed -i /etc/php83/php-fpm.d/www.conf -e 's/^;listen.group = nobody/listen.group = playsms/' && \
    sed -i /etc/php83/php.ini -e 's/^display_errors = Off/display_errors = On/' && \
    sed -i /etc/php83/php.ini -e "s#^;date.timezone =#date.timezone = ${TZ}#"
    
RUN rm -rf /home/playsms && mkdir -p /home/playsms && chown playsms:playsms -R /home/playsms && chmod 0755 /home/playsms && \
    rm -rf /var/www && mkdir -p /var/www && chown playsms:playsms -R /var/www && chmod 0755 /var/www && \
    echo 'export PATH=$PATH:/home/playsms/bin' > /home/playsms/.profile

COPY /playsms/supervisor.conf /etc/supervisor.conf
COPY /playsms/run.sh /run.sh
COPY /playsms/runner_php-fpm.sh /runner_php-fpm.sh
COPY /playsms/runner_playsmsd.sh /runner_playsmsd.sh
COPY /playsms/docker-setup.sh /_docker-setup.sh
COPY /playsms/healthcheck.sh /usr/bin/healthcheck.sh

RUN chown playsms:playsms -R /_docker-setup.sh /etc/php83 && \
	chmod 0755 /run.sh /runner_php-fpm.sh /runner_playsmsd.sh /usr/bin/healthcheck.sh && \
	chmod 0644 /_docker-setup.sh && \
	chmod 0777 -R /var/log

#USER playsms

CMD ["/run.sh", "123"]
