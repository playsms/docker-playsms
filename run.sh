#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php/8.3/apache2/php.ini

echo "=> Preparing playSMS"

[ -x /install.sh ] && /install.sh

[ -e /install.sh ] && mv /install.sh /backup.install.sh

[ -e /install.conf ] && mv /install.conf /backup.install.conf

echo "=> Exec supervisord"
exec supervisord -n
