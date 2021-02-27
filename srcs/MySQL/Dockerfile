FROM alpine:3.12.3

VOLUME [“/sys/fs/cgroup”]
RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add mariadb mariadb-common mariadb-client openrc telegraf
RUN sed -i "s/skip-networking/# skip-networking/g" /etc/my.cnf.d/mariadb-server.cnf
RUN openrc && touch /run/openrc/softlevel
COPY ./srcs/telegraf.conf /etc/telegraf.conf
COPY ./srcs/wordpress.sql /
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh
EXPOSE 3306