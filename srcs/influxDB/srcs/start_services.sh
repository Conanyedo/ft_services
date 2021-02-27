rc-service influxdb start
rc-service telegraf start

sleep 5

while sleep 2;
	do
        pgrep telegraf > /dev/null
		telegraf_status=$? 
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			exit 1
		fi
		pgrep influxd > /dev/null
		influxdb_status=$?
		if [ $influxdb_status -ne 0 ]; then
			echo "Influxdb service is not running ..."
			exit 1
		fi

	done