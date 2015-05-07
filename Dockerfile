FROM debian:squeeze
MAINTAINER Lukas Novy "lukas.novy@pirati.cz"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install gnupg -y

RUN gpg --keyserver keys.gnupg.net --recv-key 89DF5277 \
	&& gpg -a --export 89DF5277 | apt-key add -

ADD sources.list /etc/apt/sources.list

RUN apt-get update -y 

RUN apt-get install mysql-server -y 

RUN rm -rf /var/lib/mysql/mysql /var/lib/apt/lists/*

ADD start /start

RUN chmod 755 /start

ADD ca-cert.pem /etc/mysql/ca-cert.pem

EXPOSE 3306

VOLUME ["/var/lib/mysql"]
VOLUME ["/run/mysqld"]

CMD ["/start"]

