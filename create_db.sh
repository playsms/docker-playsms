#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "Usage: $0 <db_name>"
	exit 1
fi

/usr/bin/mysqld_safe >/dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

echo "=> Creating database $1"
RET=1
while [[ RET -ne 0 ]]; do
	sleep 5
	mysql -uroot -e "CREATE DATABASE $1"

	echo "=> Creating database user $1"
	mysql -uroot -e "CREATE USER '$1'@'localhost' IDENTIFIED BY 'password'" >/dev/null 2>&1 
	mysql -uroot -e "GRANT ALL PRIVILEGES ON $1.* TO '$1'@'localhost' WITH GRANT OPTION" >/dev/null 2>&1 
	mysql -uroot -e "FLUSH PRIVILEGES" >/dev/null 2>&1 
	RET=$?
done

mysqladmin -uroot shutdown

echo "=> Done!"
