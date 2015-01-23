## Supported tags and respective Dockerfile links

-	`cli` ([Dockerfile](https://github.com/webitel/freeswitch/blob/cli/Dockerfile))
- `latest` ([Dockerfile](https://github.com/webitel/freeswitch/blob/master/Dockerfile))
- `collaboration` ([Dockerfile](https://github.com/webitel/freeswitch/blob/collaboration/Dockerfile))

## FreeSWITCH

[FreeSWITCH](http://www.freeswitch.org/) with `mod_xml_curl` enabled by default.

- Current version is `1.4.15`

### FreeSWITCH client

For running only `fs_cli` container:

	docker run -i -t --name=cli  webitel/freeswitch:cli bash
	fs_cli -H 10.133.230.138

## Environment Variables

The FreeSWITCH image uses several environment variables

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

## Supported Docker versions

This image is officially supported on Docker version `1.3.2` and newest.

## User Feedback

### Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/webitel/freeswitch/issues).

