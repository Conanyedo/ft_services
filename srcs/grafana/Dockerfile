FROM alpine:3.12.3

VOLUME [ “/sys/fs/cgroup” ]
RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add wget openrc telegraf libc6-compat
RUN openrc && touch /run/openrc/softlevel
COPY ./srcs/telegraf.conf /etc/
RUN wget https://dl.grafana.com/oss/release/grafana-7.4.0.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.4.0.linux-amd64.tar.gz
RUN mv grafana-7.4.0 grafana
COPY ./srcs/defaults.ini /grafana/conf/defaults.ini
COPY ./srcs/grafana.db /grafana/data/grafana.db
RUN rm -rf grafana-7.4.0.linux-amd64.tar.gz
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh
EXPOSE 3000