#!/bin/bash
set -e

if [ "$CDR_SERVER" ]; then
	sed -i 's/CDR_SERVER/'$CDR_SERVER'/g' /conf/vars.xml
else
	sed -i 's/CDR_SERVER/$${local_ip_v4}:10021/g' /conf/vars.xml
fi

if [ "$CONF_SERVER" ]; then
	sed -i 's/CONF_SERVER/'$CONF_SERVER'/g' /conf/vars.xml
else
	sed -i 's/CONF_SERVER/$${local_ip_v4}:10024/g' /conf/vars.xml
fi

if [ "$ACR_SERVER" ]; then
	sed -i 's/ACR_SERVER/'$ACR_SERVER'/g' /conf/vars.xml
else
	sed -i 's/ACR_SERVER/$${local_ip_v4}:10030/g' /conf/vars.xml
fi

if [ "$EXT_RTP_IP" ]; then
	sed -i 's/EXT_RTP_IP/'$EXT_RTP_IP'/g' /conf/vars.xml
else
	sed -i 's/EXT_RTP_IP/auto-nat/g' /conf/vars.xml
fi

if [ "$EXT_SIP_IP" ]; then
	sed -i 's/EXT_SIP_IP/'$EXT_SIP_IP'/g' /conf/vars.xml
else
	sed -i 's/EXT_SIP_IP/auto-nat/g' /conf/vars.xml
fi

if [ "$LOGLEVEL" ]; then
	sed -i 's/LOGLEVEL/'$LOGLEVEL'/g' /conf/vars.xml
else
	sed -i 's/LOGLEVEL/err/g' /conf/vars.xml
fi

if [ "$1" = 'freeswitch' ]; then
	chown -R freeswitch:freeswitch /var/{run,lib}/freeswitch
	chown -R freeswitch:freeswitch /{logs,db,sounds,conf,certs,scripts,recordings}
	
	if [ -d /docker-entrypoint.d ]; then
		for f in /docker-entrypoint.d/*.sh; do
			[ -f "$f" ] && . "$f"
		done
	fi
	
	ulimit -s 240
	exec gosu freeswitch freeswitch -u freeswitch -g freeswitch -c \
		-sounds /sounds -recordings /recordings \
		-certs /certs -conf /conf -db /db \
		-scripts /scripts -log /logs
fi

exec "$@"