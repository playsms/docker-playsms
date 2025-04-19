#!/bin/ash

cd /home/playsms

run_it()
{
	if [ -e .installed ] && [ -e bin/playsmsd ] && [ -e etc/playsmsd.conf ] && [ -e web/index.php ]; then
		echo "playSMS has been installed properly"
		echo
		echo "Let's GO !"
		echo

		nohup /runner_php-fpm.sh &
		exec /runner_playsmsd.sh

		echo "ERROR: Something's wrong exiting..."

		exit 1
	fi
}

run_it

echo "playSMS installation starts"
echo

rm -f .installed

[ -e /_docker-setup.sh ] && cp /_docker-setup.sh docker-setup.sh && chmod +x docker-setup.sh

[ -e docker-setup.sh ] && ./docker-setup.sh

if [ -e bin/playsmsd ] && [ -e etc/playsmsd.conf ] && [ -e web/index.php ]; then
	echo
	echo "ALL GOOD"
	echo
	
	touch .installed
fi

echo "playSMS installation ends"
echo

run_it

exit 2
