#!/bin/bash
set -e

if [ "$1" = 'freeswitch' ]; then
	chown -R freeswitch:freeswitch /var/{log,lib}/freeswitch
	
	if [ -d /docker-entrypoint.d ]; then
		for f in /docker-entrypoint.d/*.sh; do
			[ -f "$f" ] && . "$f"
		done
	fi
	
	ulimit -s 240
	exec gosu freeswitch /usr/bin/freeswitch -u freeswitch -g freeswitch -c \
		-sounds /sounds -recordings /recordings \
		-certs /certs -conf /conf -db /db \
		-scripts /scripts -log /logs
fi

exec "$@"