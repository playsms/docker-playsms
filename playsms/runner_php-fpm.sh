#!/bin/ash

while true; do
    if ! ps ax | grep -v grep | grep -q "php-fpm83"; then
	    php-fpm83 -F
	fi
    sleep 5
done
