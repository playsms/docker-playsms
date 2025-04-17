#!/bin/ash

CWD=$(pwd)

cd /home/playsms/src

[ -x ./install-playsms.sh ] && 
./install-playsms.sh -y && 
[ -e ./install-playsms.sh ] && 
mv install-playsms.sh install-playsms.sh.backup
mv install.conf install.conf.backup

cd $CWD

nohup /runner_php-fpm.sh &

exec /runner_playsmsd.sh
