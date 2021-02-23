openrc default
rc-service nginx start
rc-service telegraf start
/etc/init.d/sshd start

sleep 3

while true;
	do
		pgrep nginx > /dev/null
		nginx_status=$?
		if [ $nginx_status -ne 0 ]; then
			echo "Nginx service is not running ..."
			exit
		fi
		pgrep telegraf > /dev/null
		telegraf_status=$? 
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			exit
		fi
		pgrep sshd > /dev/null
		sshd_status=$? 
		if [ $sshd_status  -ne 0 ]; then
			echo "sshd is not running ..."
			exit
		fi
	done