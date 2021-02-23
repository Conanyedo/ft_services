openrc default
rc-service vsftpd start
rc-service telegraf start

sleep 3

while true;
	do
        pgrep telegraf > /dev/null
		telegraf_status=$? 
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf is not running ..."
			exit
		fi
		pgrep vsftpd > /dev/null
		vsftpd_status=$?
		if [ $vsftpd_status -ne 0 ]; then
			echo "Vsftpd service is not running ..."
			exit
		fi
	done
