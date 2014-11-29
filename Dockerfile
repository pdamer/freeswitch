FROM debian:wheezy 
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

RUN echo 'deb http://ftp.us.debian.org/debian/ wheezy main' >> /etc/apt/sources.list &&\
	echo 'deb http://security.debian.org/ wheezy/updates main' >> /etc/apt/sources.list &&\
	apt-get -y --quiet update && apt-get -y --quiet upgrade && apt-get -y --quiet install git curl &&\
	echo 'deb http://files.freeswitch.org/repo/deb/debian/ wheezy main' >> /etc/apt/sources.list.d/freeswitch.list &&\
	curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - &&\
	git clone https://github.com/webitel/freeswitch.git /tmp/fs &&\
	mv /tmp/fs/conf /conf && rm -rf /tmp/fs

RUN apt-get -y --quiet update && apt-get -y --quiet install freeswitch freeswitch-mod-commands freeswitch-mod-conference  \
	freeswitch-mod-curl freeswitch-mod-db freeswitch-mod-dialplan-xml freeswitch-mod-event-socket freeswitch-mod-hash \
	freeswitch-mod-http-cache freeswitch-mod-isac freeswitch-mod-local-stream freeswitch-mod-native-file freeswitch-mod-lua \
	freeswitch-mod-console freeswitch-mod-opus freeswitch-mod-say-ru freeswitch-mod-sms freeswitch-mod-sndfile \
	freeswitch-mod-sofia freeswitch-mod-spandsp freeswitch-mod-tone-stream freeswitch-mod-valet-parking freeswitch-mod-voicemail \
	freeswitch-mod-xml-curl freeswitch-timezones freeswitch-mod-h26x freeswitch-mod-vp8 libfreeswitch1 \
	freeswitch-mod-dptools freeswitch-mod-expr freeswitch-mod-say-en freeswitch-mod-fifo freeswitch-mod-event-multicast \
	freeswitch-mod-rtmp freeswitch-mod-rtc freeswitch-mod-verto freeswitch-mod-shout freeswitch-mod-shell-stream \
	freeswitch-mod-spy freeswitch-mod-xml-cdr freeswitch-mod-cdr-mongodb freeswitch-mod-callcenter \
	freeswitch-mod-lcr freeswitch-mod-blacklist && apt-get clean

VOLUME ["/sounds", "/certs", "/logs", "/db", "/conf"]

ENTRYPOINT ["/usr/bin/freeswitch", "-c", "-sounds", "/sounds", "-certs", "/certs", "-log", "/logs", "-conf", "/conf", "-db", "/db"]