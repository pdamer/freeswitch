FROM ubuntu:latest
MAINTAINER Paul Damer "pdamer@gmail.com"


ENV LANG en_US.utf8

RUN apt-get -y --quiet update \
	&& apt-get -y --quiet install \
  make curl wget adduser autoconf automake devscripts gawk g++ git-core ca-certificates \
        libjpeg-dev libncurses5-dev libtool make python-dev gawk pkg-config \
        libtiff5-dev libperl-dev libgdbm-dev libdb-dev gettext libssl-dev \
        libcurl4-openssl-dev libpcre3-dev libspeex-dev libspeexdsp-dev \
        libsqlite3-dev libedit-dev libldns-dev libpq-dev


RUN cd /usr/src \
    && git clone -b v1.4 https://freeswitch.org/stash/scm/fs/freeswitch.git freeswitch

WORKDIR /usr/src/freeswitch

RUN ./bootstrap.sh -j

ADD ./modules.conf /usr/src/freeswitch/modules.conf

RUN ./configure
RUN make && make install \
&& adduser --disabled-password --quiet --system --home /usr/local/freeswitch --gecos "FreeSWITCH Voice Platform" --ingroup daemon freeswitch \
    && chown -R freeswitch:daemon /usr/local/freeswitch/ \
    && chmod -R ug=rwX,o= /usr/local/freeswitch/ \
    && chmod -R u=rwx,g=rx /usr/local/freeswitch/bin/* \
    && ln /usr/local/freeswitch/bin/fs_cli /usr/local/bin/fs_cli


RUN rm -R /usr/src/freeswitch/ \
    && apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/*

COPY conf /usr/local/freeswitch/conf
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5222/tcp 5060/tcp 5061/tcp 5080/tcp 5081/tcp 16384-16394/udp

CMD ["freeswitch"]
