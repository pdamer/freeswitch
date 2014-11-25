# Version: 0.0.5
FROM centos:centos6
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"
ENV REFRESHED_AT 2014-11-11

RUN yum update --quiet -y
RUN yum install --quiet -y libedit sox zlib bzip2 which postgresql-libs expat compat-expat1 libjpeg-turbo libvorbis speex unixODBC

ADD freeswitch /usr/local/freeswitch
COPY conf /conf
VOLUME ["/sounds", "/certs", "/logs", "/db", "/conf"]
ENTRYPOINT ["/usr/local/freeswitch/bin/freeswitch", "-c", "-rp", "-sounds", "/sounds", "-certs", "/certs", "-log", "/logs", "-conf", "/conf", "-db", "/db"]
