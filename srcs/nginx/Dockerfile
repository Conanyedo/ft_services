FROM alpine:3.12.3

# RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add nginx telegraf openssl openrc openssh
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MA/ST=Khouribga/L=Meknes/O=Conanyedo/CN=Conanyedo"
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY ./srcs/nginx.conf /etc/nginx/
COPY ./srcs/index.html /www/
COPY ./srcs/telegraf.conf /etc/
RUN sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
COPY ./srcs/password /
RUN adduser conanyedo < /password
RUN rc-update add nginx default
RUN rc-update add telegraf default
RUN rc-update add sshd default
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh

EXPOSE 80
EXPOSE 443
EXPOSE 22