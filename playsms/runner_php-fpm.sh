#!/bin/ash

killall php-fpm83 >/dev/null 2>&1
sleep 2

while true; do
	if ! ps ax | grep -v grep | grep -q "php-fpm83"; then
		php-fpm83 -F
	fi
	sleep 5
done
