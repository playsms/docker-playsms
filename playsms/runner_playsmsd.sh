#!/bin/ash

while true; do
	if ! ps ax | grep -v grep | grep -q "playsmsd.conf"; then
		/home/playsms/bin/playsmsd /home/playsms/etc/playsmsd.conf start
		
		sleep 2
		
		/home/playsms/bin/playsmsd /home/playsms/etc/playsmsd.conf check
	fi
	
	sleep 5
done
