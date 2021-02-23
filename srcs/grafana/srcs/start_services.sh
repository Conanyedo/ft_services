openrc default

rc-service telegraf start
rc-status

(cd /grafana && ./bin/grafana-server) 1>/dev/null

while sleep 1;
	do
		pgrep telegraf > /dev/null
		telegraf_status=$?
		if [ $telegraf_status  -ne 0 ]; then
			echo "Telegraf service is not running ..."
			# pkill grafana-server
			exit 1
		fi
		pgrep grafana-server > /dev/null
		grafana_status=$?
		if [ $grafana_status -ne 0 ]; then
			echo "Grafana server is not running ..."
			exit 1
		fi
	done
exit
