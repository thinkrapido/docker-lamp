FROM phusion/baseimage:latest

ADD . /build

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

RUN chmod u+x /build/*.sh
RUN /build/prepare.sh
RUN /build/system_services.sh
RUN /build/utilities.sh
RUN /build/cleanup.sh

CMD ["/sbin/my_init"]
