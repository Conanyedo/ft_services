FROM alpine:3.12.3

VOLUME [ “/sys/fs/cgroup” ]
RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc influxdb telegraf
RUN openrc && touch /run/openrc/softlevel
COPY ./srcs/telegraf.conf /etc/
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh
EXPOSE 8086