FROM debian:wheezy 
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

COPY conf /conf

RUN apt-get -y --quiet update \
	&& apt-get -y --quiet upgrade \
	&& apt-get -y --quiet install curl \
	&& echo 'deb http://files.freeswitch.org/repo/deb/debian/ wheezy main' >> /etc/apt/sources.list.d/freeswitch.list \
	&& echo 'deb http://www.deb-multimedia.org squeeze main non-free' >> /etc/apt/sources.list.d/multimedia.list \
	&& curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - \
	&& apt-get -y --quiet update \
	&& apt-get -y --quiet install deb-multimedia-keyring \
	&& apt-get -y --quiet update \
	&& apt-get -y --quiet install freeswitch libmp3lame0 lame \
	freeswitch-mod-commands \
	freeswitch-mod-conference \
	freeswitch-mod-curl \
	freeswitch-mod-db \
	freeswitch-mod-dialplan-xml \
	freeswitch-mod-xml-cdr \
	freeswitch-mod-xml-curl \
	freeswitch-mod-cdr-mongodb \
	freeswitch-mod-event-socket \
	freeswitch-mod-event-multicast \
	freeswitch-mod-event-zmq \
	freeswitch-mod-hash \
	freeswitch-mod-http-cache \
	freeswitch-mod-local-stream \
	freeswitch-mod-native-file \
	freeswitch-mod-shout \
	freeswitch-mod-shell-stream \
	freeswitch-mod-lua \
	freeswitch-mod-console \
	freeswitch-mod-say-ru \
	freeswitch-mod-say-en \
	freeswitch-mod-sms \
	freeswitch-mod-sndfile \
	freeswitch-mod-spandsp \
	freeswitch-mod-tone-stream \
	freeswitch-mod-h26x \
	freeswitch-mod-vp8 \
	freeswitch-mod-opus \
	freeswitch-mod-isac \
	freeswitch-mod-dptools \
	freeswitch-mod-expr \
	freeswitch-mod-sofia \
	freeswitch-mod-rtmp \
	freeswitch-mod-rtc \
	freeswitch-mod-verto \
	freeswitch-mod-valet-parking \
	freeswitch-mod-spy \
	freeswitch-mod-voicemail \
	freeswitch-mod-fifo \
	freeswitch-mod-callcenter \
	freeswitch-mod-lcr \
	freeswitch-mod-blacklist \
	freeswitch-timezones \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

VOLUME ["/sounds", "/certs", "/logs", "/db", "/conf", "/recordings", "/scripts"]

ENTRYPOINT ["freeswitch", "-c", "-rp", "-sounds", "/sounds", "-certs", "/certs", "-log", "/logs", "-conf", "/conf", "-db", "/db", "-recordings", "/recordings", "-scripts", "/scripts"]