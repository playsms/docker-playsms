#!/bin/ash

if ! ps ax | grep -v grep | grep -q "playsmsd.conf"; then
	exit 1
fi

exit 0
