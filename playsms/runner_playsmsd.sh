#!/bin/ash

killall php >/dev/null 2>&1
sleep 2

if [ ! -e .installed ] || [ ! -e /home/playsms/bin/playsmsd ] || [ ! -e /home/playsms/etc/playsmsd.conf ] || [ ! -e /home/playsms/web/index.php ]; then
	echo "playSMS is not installed properly"
	
	exit 1
fi

while true; do
	if ! ps ax | grep -v grep | grep -q "playsmsd.conf"; then
		echo
		su - playsms -c "/home/playsms/bin/playsmsd /home/playsms/etc/playsmsd.conf start"
		sleep 2
		echo
		su - playsms -c "/home/playsms/bin/playsmsd /home/playsms/etc/playsmsd.conf check"
		echo
	fi
	sleep 5
done
