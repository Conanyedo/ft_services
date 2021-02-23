FROM alpine:3.12.3

RUN apk update
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add nginx telegraf
RUN apk add php7 php7-fpm php7-mcrypt mysql mysql-client php-session php-mbstring php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype 
RUN apk add openrc
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY ./srcs/nginx.conf /etc/nginx/
COPY ./srcs/telegraf.conf /etc/
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN rm phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages phpmyadmin
RUN mkdir -p /phpmyadmin/tmp
RUN chmod 777 /phpmyadmin/tmp/
RUN rm /phpmyadmin/config.sample.inc.php
COPY ./srcs/config.inc.php /phpmyadmin/
RUN mv phpmyadmin /www/
RUN rc-update add nginx default
RUN rc-update add telegraf default
RUN rc-update add php-fpm7 default
COPY ./srcs/start_services.sh /
RUN chmod 777 /start_services.sh
CMD /start_services.sh
EXPOSE 5000