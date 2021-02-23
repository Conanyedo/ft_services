openrc default
rc-service influxdb start
rc-service telegraf start
rc-status

while sleep 1;
	do
        pgrep telegraf > /dev/null
		telegraf_status=$? 
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			exit
		fi
		pgrep influxd > /dev/null
		influxdb_status=$?
		if [ $influxdb_status -ne 0 ]; then
			echo "Influxdb service is not running ..."
			exit
		fi

	done