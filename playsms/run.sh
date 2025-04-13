#!/bin/bash

export TERM=xterm-256color

[ -x /app/install-playsms.sh ] && cd /app && ./install-playsms.sh -y

[ -e /app/install-playsms.sh ] && mv /app/install-playsms.sh /app/backup.install-playsms.sh 

[ -e /app/install.conf ] && mv /app/install.conf /app/backup.install.conf

exec supervisord -n

exit 0
