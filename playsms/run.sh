#!/bin/ash

export TERM=xterm-256color

CWD=$(pwd)

cd /app

[ -x ./docker-setup.sh ] && ./docker-setup.sh

[ -e ./docker-setup.sh ] && mv docker-setup.sh backup.docker-setup.sh

cd $CWD

exec supervisord -c /etc/supervisor.conf

exit 0
