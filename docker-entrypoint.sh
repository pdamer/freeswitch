#!/bin/bash
set -e

printf 'Determining internal_ip value...\n'

INTERNAL_IP='192.168.99.103'
#ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep '192'

  EXT_RTP_IP=$INTERNAL_IP
  EXT_SIP_IP=$INTERNAL_IP
  DOMAIN_IP=$INTERNAL_IP
  BIND_SERVER_IP='192.168.99.103'
  RAYO_IP=$INTERNAL_IP
  RAYO_DOMAIN_IP='192.168.99.1'

if [ "$EXT_RTP_IP" ]; then
  sed -i 's/EXT_RTP_IP/'$EXT_RTP_IP'/g' /usr/local/freeswitch/conf/vars.xml
else
  sed -i 's/EXT_RTP_IP/auto-nat/g' /usr/local/freeswitch/conf/vars.xml
fi

if [ "$EXT_SIP_IP" ]; then
  sed -i 's/EXT_SIP_IP/'$EXT_SIP_IP'/g' /usr/local/freeswitch/conf/vars.xml
else
  sed -i 's/EXT_SIP_IP/auto-nat/g' /usr/local/freeswitch/conf/vars.xml
fi

if [ "$DOMAIN_IP" ]; then
  sed -i 's/DOMAIN_IP/'$DOMAIN_IP'/g' /usr/local/freeswitch/conf/vars.xml
else
  sed -i 's/DOMAIN_IP/auto-nat/g' /usr/local/freeswitch/conf/vars.xml
fi

if [ "$BIND_SERVER_IP" ]; then
  sed -i 's/BIND_SERVER_IP/'$BIND_SERVER_IP'/g' /usr/local/freeswitch/conf/vars.xml
else
  sed -i 's/BIND_SERVER_IP/auto-nat/g' /usr/local/freeswitch/conf/vars.xml
fi

if [ "$RAYO_IP" ]; then
  sed -i 's/RAYO_IP/'$RAYO_IP'/g' /usr/local/freeswitch/conf/vars.xml
else
  sed -i 's/RAYO_IP/auto-nat/g' /usr/local/freeswitch/conf/vars.xml
fi

if [ "$RAYO_DOMAIN_IP" ]; then
  sed -i 's/RAYO_DOMAIN_IP/'$RAYO_DOMAIN_IP'/g' /usr/local/freeswitch/conf/vars.xml
else
  sed -i 's/RAYO_DOMAIN_IP/auto-nat/g' /usr/local/freeswitch/conf/vars.xml
fi




printf "internal_ip = ${INTERNAL_IP}\n"

if [ "$1" = 'freeswitch' ]; then
  exec /usr/local/freeswitch/bin/freeswitch
fi

exec "$@"
