## Supported tags and respective Dockerfile links

- `cli` ([Dockerfile](https://github.com/webitel/freeswitch/blob/cli/Dockerfile))
- `1.4` ([Dockerfile](https://github.com/webitel/freeswitch/blob/1.4/Dockerfile)) default FreeSWITCH v.1.4
- `latest` ([Dockerfile](https://github.com/webitel/freeswitch/blob/master/Dockerfile)) for [Webitel](http://webitel.ua/)
- `onbuild` ([Dockerfile](https://github.com/webitel/freeswitch/blob/onbuild/Dockerfile))

## FreeSWITCH

[FreeSWITCH](http://www.freeswitch.org/) - FREE Multi-Protocol Soft Switch.

Dial plan in `latest` works only with [Webitel](http://webitel.ua/) [Advanced Call Router](https://github.com/webitel/acr)

- Current version is `1.4.15`

### Default FreeSWITCH image

To run default FreeSWITCH with vanilla config (included `mod_bcg729`), just type:

	docker run -d -t —privileged=true —net=“host” —name=“FS” webitel/freeswitch:1.4

### FreeSWITCH client

For running only `fs_cli` container from `cli` tag:

	docker run -i -t —name=cli webitel/freeswitch:cli fs_cli -H 10.133.230.138

Or You can run from the `latest` tag:
	
	docker run -i -t —name=cli webitel/freeswitch:latest fs_cli -H 10.133.230.138

### Build own FreeSWITCH image

You can build Your own FreeSWITCH image or an additional module for FreeSWITCH with `onbuild` image tag. 

An example of the Dockerfile for `mod_bcg729`:

	FROM webitel/freeswitch:onbuild
	
	RUN git clone https://github.com/xadhoom/mod_bcg729.git \
        && cd mod_bcg729 \
        && sed -i 's/opt\/freeswitch\/include/usr\/include/g' Makefile \
        && sed -i 's/opt\/freeswitch\/mod/usr\/lib\/freeswitch\/mod/g' Makefile \
        && mkdir -p /usr/lib/freeswitch/mod \
        && make && make install

## Environment Variables

The FreeSWITCH `latest` image for [Webitel](http://webitel.ua/) uses several environment variables

`CONF_SERVER`

This environment variable used for HTTP server and port with XML configurations.

`CDR_SERVER`

This environment variable used for uploading call records.

`EXT_SIP_IP`

This optional environment variable is used in sip profile for SIP. Default is `auto-nat`.

`EXT_RTP_IP`

This optional environment variable is used in sip profile for RTP. Default is `auto-nat`.

`LOGLEVEL`

This optional environment variable for FreeSWITCH log level. Default is `err`.

`ACR_SERVER`

This environment variable used for connection to ACR with FreeSWITCH `socket` application. You must set IP:PORT. 

Used in the `ACR` XML Dialplan extension:

	<extension name="ACR">
		<condition>
			<action application="socket" data="ACR_SERVER:10025 async full”/>
		</condition>
	</extension>

## Supported Docker versions

This image is officially supported on Docker version `1.5` and newest.

## User Feedback

### Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/webitel/freeswitch/issues).

