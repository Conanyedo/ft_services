openrc default

rc-service nginx start
rc-service telegraf start
rc-service php-fpm7 start
# rc-status

while sleep 1;
	do
		# if ! pgrep nginx ; then
		# 	echo "Nginx service is not running ..."
		# 	exit 1
		# fi
		# if ! pgrep php ; then
		# 	echo "Php service is not running ..."
		# 	exit 1
		# fi
		# if ! pgrep telegraf ; then
		# 	echo "Telegraf is not running ..."
		# 	exit 1
		# fi
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