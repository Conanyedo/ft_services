FROM alpine:3.12.3

RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add openrc influxdb telegraf
COPY ./srcs/telegraf.conf /etc/
RUN rc-update add influxdb default
RUN rc-update add telegraf default
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh
EXPOSE 8086