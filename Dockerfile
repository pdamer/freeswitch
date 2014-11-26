# Version: 0.0.7
FROM centos:centos6
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

RUN yum update --quiet -y \
	&& yum install --quiet -y libedit sox zlib tar bzip2 which postgresql-libs expat compat-expat1 libjpeg-turbo libvorbis speex unixODBC git \
	&& git clone https://github.com/webitel/freeswitch.git /tmp/fs \
	&& mv /tmp/fs/conf /conf \
	&& rm -rf /tmp/fs \
	&& curl -SL "http://builds.webitel.com/3.0/fs_master.tgz" -o /tmp/fs.tgz \
	&& cd /usr/local \
	&& tar xzvf /tmp/fs.tgz \
	&& rm -rf /tmp/fs.tgz

VOLUME ["/sounds", "/certs", "/logs", "/db", "/conf"]
ENTRYPOINT ["/usr/local/freeswitch/bin/freeswitch", "-c", "-rp", "-sounds", "/sounds", "-certs", "/certs", "-log", "/logs", "-conf", "/conf", "-db", "/db"]