#!/bin/bash
set -e

if [ "$1" = 'freeswitch' ]; then
	chown -R freeswitch:freeswitch /var/{run,lib}/freeswitch
	chown -R freeswitch:freeswitch /{logs,db,sounds,conf,certs,scripts,recordings}
	
	if [ -d /docker-entrypoint.d ]; then
		for f in /docker-entrypoint.d/*.sh; do
			[ -f "$f" ] && . "$f"
		done
	fi
	
	ulimit -s 240
	chown -R freeswitch:freeswitch /usr/local/freeswitch
	chmod -R 775 /usr/local/freeswitch
	exec gosu freeswitch /usr/local/freeswitch/bin/freeswitch -u freeswitch -g freeswitch -c \
		-sounds /sounds -recordings /recordings \
		-certs /certs -conf /conf -db /db \
		-scripts /scripts -log /logs
fi

exec "$@"