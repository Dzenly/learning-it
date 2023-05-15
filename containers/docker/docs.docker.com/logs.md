https://docs.docker.com/config/containers/logging/

`docker logs`

By default - as -it.

STDOUT, STDERR.

https://docs.docker.com/config/containers/logging/plugins/

/etc/docker/daemon.json

"log-driver": "json-file",

docker info --format '{{.LoggingDriver}}'

--log-driver --log-opt

docker inspect -f '{{.HostConfig.LogConfig.Type}}' <CONTAINER>

blocking (default) / non-blocking.

For non blocking mode - old unread messages are lost.

max-buffer-size defaults to 1 megabyte

Dual logging - only for Enterprise.

https://docs.docker.com/config/containers/logging/log_tags/


https://docs.docker.com/config/containers/logging/local/

local

```json
{
  "log-driver": "local",
  "log-opts": {
    "max-size": "10m"
  }
}
```
```
docker run \
      --log-driver local --log-opt max-size=10m \
      alpine echo hello world
```

max-size
max-file
compress

https://docs.docker.com/config/containers/logging/json-file/






