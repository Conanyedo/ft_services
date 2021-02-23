FROM alpine:3.12.3

RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add mysql mysql-client openrc telegraf
COPY ./srcs/telegraf.conf /etc/
COPY ./srcs/wordpress.sql /
RUN rc-update add mariadb default
RUN rc-update add telegraf default
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh
EXPOSE 3306