#!/bin/ash

MYSQL_USER=$PLAYSMS_DB_USER
MYSQL_PWD=$PLAYSMS_DB_PASS
MYSQL_DBNAME=$PLAYSMS_DB_NAME
MYSQL_HOST=$PLAYSMS_DB_HOST
MYSQL_TCP_PORT=$PLAYSMS_DB_PORT
PATHSRC="/home/playsms/src"
PATHWEB="/home/playsms/web"
PATHLIB="/home/playsms/lib"
PATHBIN="/home/playsms/bin"
PATHLOG="/home/playsms/log"
PATHCONF="/home/playsms/etc"

echo
echo "=================================================================="
echo
echo "INSTALL DATA:"
echo
echo "MySQL username      = $MYSQL_USER"
echo "MySQL password      = $MYSQL_PWD"
echo "MySQL database      = $MYSQL_DBNAME"
echo "MySQL host          = $MYSQL_HOST"
echo "MySQL port          = $MYSQL_TCP_PORT"
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
INSTALLED=0 &&
mkdir -p $PATHCONF $PATHBIN $PATHLIB $PATHLOG $PATHWEB &&
git clone --branch $PLAYSMS_VERSION --depth=1 https://github.com/playsms/playsms.git $PATHSRC &&
cd $PATHSRC &&
./getcomposer.sh &&
cp -rR -f web/* $PATHWEB/ &&
cp -f web/config-dist.php $PATHWEB/config.php &&
ln -s $PATHSRC/daemon/linux/bin/playsmsd.php $PATHBIN/playsmsd &&
touch $PATHCONF/playsmsd.conf &&
touch $PATHLOG/audit.log $PATHLOG/playsms.log &&
ln -s $PATHWEB /var/www/html &&
ln -s /etc/php83 /home/playsms/php83 &&
chmod -R 0777 $PATHLOG $PATHWEB/storage &&
chown -R playsms:playsms $PATHCONF $PATHBIN $PATHLIB $PATHLOG $PATHWEB &&
INSTALLED=1
if [ ! "$INSTALLED" = "1" ]; then
	echo "playSMS installation has failed. Exitting..."
	exit 128
fi
echo
echo "=================================================================="
echo
sed -i "s/#MYSQL_HOST#/$MYSQL_HOST/g" $PATHWEB/config.php
sed -i "s/#MYSQL_TCP_PORT#/$MYSQL_TCP_PORT/g" $PATHWEB/config.php
sed -i "s/#MYSQL_DBNAME#/$MYSQL_DBNAME/g" $PATHWEB/config.php
sed -i "s/#MYSQL_USER#/$MYSQL_USER/g" $PATHWEB/config.php
sed -i "s/#MYSQL_PWD#/$MYSQL_PWD/g" $PATHWEB/config.php
sed -i "s|#PATHLOG#|$PATHLOG|g" $PATHWEB/config.php
echo "PLAYSMS_PATH=\"$PATHWEB\"" > $PATHCONF/playsmsd.conf
echo "PLAYSMS_LIB=\"$PATHLIB\"" >> $PATHCONF/playsmsd.conf
echo "PLAYSMS_BIN=\"$PATHBIN\"" >> $PATHCONF/playsmsd.conf
echo "PLAYSMS_LOG=\"$PATHLOG\"" >> $PATHCONF/playsmsd.conf
echo "DAEMON_SLEEP=\"1\"" >> $PATHCONF/playsmsd.conf
echo "ERROR_REPORTING=\"E_ALL ^ (E_NOTICE | E_WARNING)\"" >> $PATHCONF/playsmsd.conf
echo "playSMS daemon config file: $PATHCONF/playsmsd.conf"
echo
cat $PATHCONF/playsmsd.conf
echo
echo "=================================================================="
echo
FRESH_INSTALL=0
SQL_FILE="$PATHSRC/db/playsms.sql"
if echo "SELECT uid FROM playsms_tblUser WHERE status=2;" | mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_TCP_PORT} ${MYSQL_DBNAME} &>/dev/null; then
	echo "Database already exists."
	echo "Importing data skipped and installation process will continue."
else
	echo "CREATE DATABASE ${MYSQL_DBNAME};" | mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_TCP_PORT} &>/dev/null
	echo "Importing data to database..."
	if mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_TCP_PORT} ${MYSQL_DBNAME} < ${SQL_FILE} &>/dev/null; then
		echo "Database has been installed successfully."
		FRESH_INSTALL=1
	else
		echo "ERROR: Failed to import data from ${SQL_FILE} to database ${MYSQL_DBNAME}."
		echo 
		echo "Installation process will continue but you may have a broken system."
		echo 
		echo "Make sure database related configuration are all good before trying again."
	fi
fi
echo
echo "=================================================================="
echo
if [ "$FRESH_INSTALL" == "1" ]; then
	WEB_ADMIN_PASSWORD_HASHED="$(php -r "echo password_hash(\"$WEB_ADMIN_PASSWORD\", PASSWORD_BCRYPT, [\"cost\"=>12]);")"
	if echo "UPDATE playsms_tblUser SET password='$WEB_ADMIN_PASSWORD_HASHED' WHERE username='admin';" | \
		mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_TCP_PORT} ${MYSQL_DBNAME} &>/dev/null; 
	then
		echo "Web admin password has been successfully updated."
		echo
		echo "WARNING:"
		echo "	- Web admin username is admin"
		echo "	- Web admin password is $WEB_ADMIN_PASSWORD"
		echo "	- This is just the default admin password"
		echo "	- Login and change it to your own strong password"
		sleep 5
	else
		echo "WARNING: Failed to update web admin password."
	fi
	echo
	echo "=================================================================="
	echo
fi
echo "playSMS has been installed on your system"
echo
echo "Your playSMS daemon script operational guide:"
echo 
echo "- To start it : playsmsd start"
echo "- To stop it  : playsmsd stop"
echo "- To check it : playsmsd check"
echo
echo "=================================================================="
echo 
echo "INSTALLATION FINISHED."
echo
echo "=================================================================="
echo

exit 0
