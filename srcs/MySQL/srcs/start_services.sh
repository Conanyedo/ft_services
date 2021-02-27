rc-service telegraf start

if [ ! -d "/var/lib/mysql/wordpress/" ]; then
	/etc/init.d/mariadb setup
	rc-service mariadb start
	mysql -u root -e "create user 'conanyedo'@'%' identified by 'conanyedo'"
	mysql -u root -e "CREATE DATABASE wordpress"
	mysql -u root < wordpress.sql
	mysql -u root -e "GRANT ALL ON *.* to 'conanyedo'@'%'"
	mysql -u root -e "FLUSH PRIVILEGES"
	mysql -u root -e "exit"
	rc-service mariadb stop
fi

mysqld_safe &

sleep 5

while sleep 2;
	do
		pgrep telegraf > /dev/null
		telegraf_status=$? 
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			exit 1
		fi
		pgrep mysql > /dev/null
		mariadb_status=$?
		if [ $mariadb_status -ne 0 ]; then
			echo "Mariadb service is not running ..."
			exit 1
		fi
	done