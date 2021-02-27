FROM alpine:3.12.3

VOLUME [ “/sys/fs/cgroup” ]
RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add vsftpd openrc openssl telegraf
RUN openrc && touch /run/openrc/softlevel
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj "/C=MA/ST=Khouribga/L=Meknes/O=Conanyedo/CN=Conanyedo"
COPY ./srcs/telegraf.conf /etc/
COPY ./srcs/vsftpd.conf /etc/vsftpd/
COPY ./srcs/vsftpd.users_list /etc/vsftpd/
COPY ./srcs/password /
RUN adduser conanyedo < /password
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh
EXPOSE 21