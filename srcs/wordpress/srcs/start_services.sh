openrc default
rc-service nginx start
rc-service telegraf start
rc-service php-fpm7 start

sleep 3

while true;
	do
		pgrep telegraf > /dev/null
		telegraf_status=$? 
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			exit
		fi
		pgrep nginx > /dev/null
		nginx_status=$?
		if [ $nginx_status -ne 0 ]; then
			echo "Nginx service is not running ..."
			exit
		fi
		pgrep php > /dev/null
		php_status=$?
		if [ $php_status -ne 0 ]; then
			echo "Php service is not running ..."
			exit
		fi
	done