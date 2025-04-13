#!/bin/bash

while true; do
    if ! ps ax | grep -v grep | grep -q "playsmsd.conf"; then
	    su - playsms -c "/usr/local/bin/playsmsd start >/dev/null 2>&1"
	fi
    sleep 5
done
