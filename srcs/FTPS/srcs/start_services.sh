openrc default

rc-service vsftpd start
rc-service telegraf start
rc-status

while sleep 1;
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
