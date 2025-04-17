#!/bin/ash

INSTALLCONF="./install.conf"

if [ -n "$1" ]; then
	if [ -e "$1" ]; then
		INSTALLCONF=$1
	fi
fi

bypass=false

while getopts ":y" opt; do
  case $opt in
    y)
      bypass=true
      ;;
    \?)
      ;;
  esac
done


if [ ! -e "$INSTALLCONF" ]; then
	echo
	echo "ERROR: unable to find install.conf"
	echo
	echo "Please rename install.conf.dist to install.conf"
	echo "    cp install.conf.dist install.conf"
	echo
	echo "Edit install.conf to suit your system configuration"
	echo "    vi install.conf"
	echo
	echo "Please re-run this script once install.conf edited and saved"
	echo "    ./install-playsms.sh"
	echo
	exit 1
fi

. $INSTALLCONF




# ========================================
# DO NOT CHANGE ANYTHING BELOW THIS LINE #
# UNLESS YOU KNOW WHAT YOU'RE DOING      #
# ========================================





clear
if ! $bypass; then
    echo
    echo "playSMS Install Script for Ubuntu (Debian based)"
    echo
    echo "=================================================================="
    echo "WARNING:"
    echo "- This install script WILL NOT upgrade currently installed playSMS"
    echo "- This install script WILL REMOVE your current playSMS database"
    echo "- This install script is compatible ONLY with playSMS version 1.4"
    echo "- Please BACKUP before proceeding"
    echo "=================================================================="
    echo
else 
	echo
	echo "playSMS Install Script"
	echo
	echo "==================================================================="
	echo "WARNING:"
	echo "- This install script is AUTOMATED and will ignore all user input"
	echo "- if you dont understand what you are doing please click [Control+C] to abort"
	echo "- You have 3 seconds to cancel before any changes will be made"
	echo "==================================================================="
	echo
	sleep 1
	echo "- 3s"
	sleep 1
	echo "- 2s"
	sleep 1
	echo "- 1s"
	sleep 1
	echo
	echo "==================================================================="
	echo "- Installation started -"
	echo "==================================================================="
	echo

fi
USERID=$(id -u)
if [ "$USERID" = "0" ]; then
	echo "You ARE running this installation script as root"
	echo "That means you need to make sure that you know what you're doing"
	echo
	echo "=================================================================="
	echo
	echo "Proceed ?"
	echo
    if ! $bypass; then
        confirm=
        while [ -z $confirm ]
        do
            read -p "When you're ready press [y/Y] or press [Control+C] to cancel " confirm
            if [[ $confirm == 'y' ]]; then
                break
            fi
            if [[ $confirm == 'Y' ]]; then
                break
            fi
            confirm=
        done
    fi
	echo
	echo "=================================================================="
	echo
else
	echo "You are NOT running this installation script as root"
	echo "That means you need to make sure that this Linux user has"
	echo "permission to create necessary directories"
	echo
	echo "=================================================================="
	echo
	echo "Proceed ?"
	echo
    if ! $bypass; then
        confirm=
        while [ -z $confirm ]
        do
            read -p "When you're ready press [y/Y] or press [Control+C] to cancel " confirm
            if [[ $confirm == 'y' ]]; then
                break
            fi
            if [[ $confirm == 'Y' ]]; then
                break
            fi
            confirm=
        done
    fi
	echo
	echo "=================================================================="
	echo
fi

echo "INSTALL DATA:"
echo

echo "MySQL username      = $MYSQL_USER"
echo "MySQL password      = $MYSQL_PWD"
echo "MySQL database      = $MYSQL_DBNAME"
echo "MySQL host          = $MYSQL_HOST"
echo "MySQL port          = $MYSQL_TCP_PORT"
echo
echo "Web server user     = $WEBSERVERUSER"
echo "Web server group    = $WEBSERVERGROUP"
echo
echo "playSMS source path = $PATHSRC"
echo
echo "playSMS web path    = $PATHWEB"
echo "playSMS lib path    = $PATHLIB"
echo "playSMS bin path    = $PATHBIN"
echo "playSMS log path    = $PATHLOG"
echo
echo "playSMS conf path   = $PATHCONF"
echo

echo "=================================================================="
echo
echo "Please read and confirm INSTALL DATA above"
echo
if ! $bypass; then
    confirm=
    while [ -z $confirm ]
    do
        read -p "When you're ready press [y/Y] or press [Control+C] to cancel " confirm
        if [[ $confirm == 'y' ]]; then
            break
        fi
        if [[ $confirm == 'Y' ]]; then
            break
        fi
        confirm=
    done
fi
echo
echo "=================================================================="
echo

sleep 1

echo "Are you sure ?"
echo
echo "Please read and check again the INSTALL DATA above"
echo
if ! $bypass; then
    confirm=
    while [ -z $confirm ]
    do
        read -p "When you're ready press [y/Y] or press [Control+C] to cancel " confirm
        if [[ $confirm == 'y' ]]; then
            break
        fi
        if [[ $confirm == 'Y' ]]; then
            break
        fi
        confirm=
    done
fi
echo
echo "=================================================================="
echo
echo "Installation is in progress"
echo
echo "DO NOT press [Control+C] until this script ends"
echo
echo "=================================================================="
echo

echo -n "Start"
set -e
echo -n .
#mkdir -p $PATHWEB $PATHLIB $PATHLOG
echo -n .
#cp -rf web/* $PATHWEB
set +e
echo -n .
## TODO check with only dbname
mysqladmin -u $MYSQL_USER -p$MYSQL_PWD -h $MYSQL_HOST -P $MYSQL_TCP_PORT create $MYSQL_DBNAME >/dev/null 2>&1
set -e
echo -n .
## TODO check with only dbname
mysql -u $MYSQL_USER -p$MYSQL_PWD -h $MYSQL_HOST -P $MYSQL_TCP_PORT $MYSQL_DBNAME < db/playsms.sql >/dev/null 2>&1
echo -n .
#cp $PATHWEB/config-dist.php $PATHWEB/config.php
echo -n .
sed -i "s/#MYSQL_HOST#/$MYSQL_HOST/g" $PATHWEB/config.php
echo -n .
sed -i "s/#MYSQL_TCP_PORT#/$MYSQL_TCP_PORT/g" $PATHWEB/config.php
echo -n .
sed -i "s/#MYSQL_DBNAME#/$MYSQL_DBNAME/g" $PATHWEB/config.php
echo -n .
sed -i "s/#MYSQL_USER#/$MYSQL_USER/g" $PATHWEB/config.php
echo -n .
sed -i "s/#MYSQL_PWD#/$MYSQL_PWD/g" $PATHWEB/config.php
echo -n .
sed -i "s|#PATHLOG#|$PATHLOG|g" $PATHWEB/config.php
echo -n .

if [ "$USERID" = "0" ]; then
	chown -R $WEBSERVERUSER.$WEBSERVERGROUP $PATHWEB $PATHLIB $PATHLOG
	echo -n .
fi

mkdir -p $PATHCONF $PATHBIN
echo -n .
#touch $PATHCONF/playsmsd.conf
echo -n .
echo "PLAYSMS_PATH=\"$PATHWEB\"" > $PATHCONF/playsmsd.conf
echo "PLAYSMS_LIB=\"$PATHLIB\"" >> $PATHCONF/playsmsd.conf
echo "PLAYSMS_BIN=\"$PATHBIN\"" >> $PATHCONF/playsmsd.conf
echo "PLAYSMS_LOG=\"$PATHLOG\"" >> $PATHCONF/playsmsd.conf
echo "DAEMON_SLEEP=\"1\"" >> $PATHCONF/playsmsd.conf
echo "ERROR_REPORTING=\"E_ALL ^ (E_NOTICE | E_WARNING)\"" >> $PATHCONF/playsmsd.conf
#chmod 644 $PATHCONF/playsmsd.conf
echo -n .
#cp -rR daemon/linux/bin/playsmsd.php $PATHBIN/playsmsd
#chmod 755 $PATHBIN/playsmsd
echo -n .
echo "end"
echo
$PATHBIN/playsmsd $PATHCONF/playsmsd.conf check
sleep 3
echo
$PATHBIN/playsmsd $PATHCONF/playsmsd.conf start
sleep 3
echo
$PATHBIN/playsmsd $PATHCONF/playsmsd.conf status
sleep 3
echo

echo
echo "playSMS has been installed on your system"
echo
echo
echo "Your playSMS daemon script operational guide:"
echo 
echo "- To start it : playsmsd $PATHCONF/playsmsd.conf start"
echo "- To stop it  : playsmsd $PATHCONF/playsmsd.conf stop"
echo "- To check it : playsmsd $PATHCONF/playsmsd.conf check"
echo

#cp install.conf install.conf.backup >/dev/null 2>&1

echo
echo
echo "ATTENTION"
echo "========="
echo
echo "When message \"unable to start playsmsd\" occurred above, please check:"
echo
echo "1. Possibly theres an issue with composer updates, try to run: \"./composer update\""
echo "2. Manually run playsmsd, \"playsmsd $PATHCONF/playsmsd.conf start\", and then \"playsmsd $PATHCONF/playsmsd.conf status\""
echo
echo

exit 0
