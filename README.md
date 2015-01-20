## Supported tags and respective Dockerfile links

-	`cli` ([Dockerfile](https://github.com/webitel/freeswitch/blob/cli/Dockerfile))
- `latest` ([Dockerfile](https://github.com/webitel/freeswitch/blob/master/Dockerfile))
- `collaboration` ([Dockerfile](https://github.com/webitel/freeswitch/blob/collaboration/Dockerfile))

## FreeSWITCH

[FreeSWITCH](http://www.freeswitch.org/) with minimalistic configuration for Webitel.

- Current version is `1.4.15`

### FreeSWITCH client

For running only `fs_cli` container:

	docker run -i -t --name=cli  webitel/freeswitch:cli bash
	fs_cli -H 10.133.230.138

## Supported Docker versions

This image is officially supported on Docker version `1.3.2` and newest.

## User Feedback

### Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/webitel/freeswitch/issues).

