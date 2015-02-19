# vim:set ft=dockerfile:
FROM debian:wheezy
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get -y --quiet upgrade && apt-get install -y curl tar gzip && rm -rf /var/lib/apt/lists/* \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

# make the "en_US.UTF-8"
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENV FS_MAJOR 1.4
ENV FS_VERSION 1.4.15

RUN echo 'deb http://files.freeswitch.org/repo/deb/debian/ wheezy main' >> /etc/apt/sources.list.d/freeswitch.list \
    && curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - \
    && apt-get -y --quiet update \
    && apt-get -y --quiet install freeswitch tzdata \
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
    freeswitch-mod-logfile \
    freeswitch-timezones \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove curl

RUN mkdir -p /docker-entrypoint.d /logs /certs /sounds /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch

VOLUME ["/sounds", "/certs", "/db", "/conf", "/recordings", "/scripts", "/docker-entrypoint.d"]

COPY conf /conf
COPY docker-entrypoint.sh /

## mod_verto NAT
## v1.5 (2015.02.19)
ADD http://dev.it-sfera.com.ua/fs.tar.gz /usr/local/fs.tar.gz
RUN mkdir /usr/local/freeswitch && cd /usr/local/freeswitch && tar xzvf ../fs.tar.gz && rm ../fs.tar.gz

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]