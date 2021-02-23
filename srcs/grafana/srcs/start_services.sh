openrc default
rc-service telegraf start
(cd /grafana && ./bin/grafana-server) 1>/dev/null

sleep 3

while true;
	do
		pgrep telegraf > /dev/null
		telegraf_status=$?
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			exit
		fi
		pgrep grafana-server > /dev/null
		grafana_status=$?
		if [ $grafana_status -ne 0 ]; then
			echo "Grafana server is not running ..."
			exit
		fi
	done
exit
