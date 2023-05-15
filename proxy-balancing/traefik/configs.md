https://docs.traefik.io/providers/docker/

```
labels:
      - traefik.http.routers.my-container.rule=Host(`example.com`)
```

# Port detection

Traefik gets private IP and Port of containers from Docker API.

* If container exposes one port Traefik uses this port for priv. communication.

* If multiple of zero - you must manually specify port.
traefik.http.services.<service_name>.loadbalancer.server.port

# Host networking

