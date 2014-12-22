FROM debian:wheezy 
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

COPY conf /conf

RUN apt-get -y --quiet update \
    && apt-get -y --quiet upgrade \
    && apt-get -y --quiet install curl \
    && echo 'deb http://files.freeswitch.org/repo/deb/debian/ wheezy main' >> /etc/apt/sources.list.d/freeswitch.list \
    && curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - \
    && apt-get -y --quiet update \
    && apt-get -y --quiet install freeswitch \
    freeswitch-mod-commands \
    freeswitch-mod-conference \
    freeswitch-mod-curl \
    freeswitch-mod-db \
    freeswitch-mod-dialplan-xml \
    freeswitch-mod-xml-curl \
    freeswitch-mod-event-socket \
    freeswitch-mod-hash \
    freeswitch-mod-http-cache \
    freeswitch-mod-local-stream \
    freeswitch-mod-native-file \
    freeswitch-mod-shout \
    freeswitch-mod-lua \
    freeswitch-mod-console \
    freeswitch-mod-say-ru \
    freeswitch-mod-say-en \
    freeswitch-mod-sms \
    freeswitch-mod-sndfile \
    freeswitch-mod-spandsp \
    freeswitch-mod-tone-stream \
    freeswitch-mod-vp8 \
    freeswitch-mod-opus \
    freeswitch-mod-isac \
    freeswitch-mod-dptools \
    freeswitch-mod-expr \
    freeswitch-mod-sofia \
    freeswitch-mod-rtc \
    freeswitch-mod-verto \
    freeswitch-timezones \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME ["/sounds", "/certs", "/logs", "/db", "/conf"]

ENTRYPOINT ["freeswitch", "-c", "-rp", "-sounds", "/sounds", "-certs", "/certs", "-log", "/logs", "-conf", "/conf", "-db", "/db"]