openrc default
/etc/init.d/mariadb setup
rc-service telegraf start
rc-service mariadb start

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE USER 'conanyedo'@'%' IDENTIFIED BY 'conanyedo';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'conanyedo'@'%';"
mysql -e "FLUSH PRIVILEGES;"
mysql -u root < wordpress.sql

rc-service mariadb restart

sleep 3

while true;
	do
		pgrep telegraf > /dev/null
		telegraf_status=$? 
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			exit
		fi
		pgrep mysql > /dev/null
		mariadb_status=$?
		if [ $mariadb_status -ne 0 ]; then
			echo "Mariadb service is not running ..."
			exit
		fi
	done