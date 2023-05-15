https://docs.docker.com/compose/compose-file/#network

network - network for RUN instructions during build.

network: none - ok.

https://docs.docker.com/compose/compose-file/#networks

```yaml
services:
  some-service:
    networks:
      - some-network
      - other-network
```

https://docs.docker.com/compose/compose-file/#network-configuration-reference

driver (usually - bridge on single host and overlay on swarm)

overlay - name network across multiple nodes in swarm.

networks aliases:

```yaml
networks:
  nonet:
    external: true
    name: none
```

internal.
By default docker connects `bridge` network
true - for externaly isolated overlay network.

labels

external: true - for outside created network.


Alias:
```
network1:
  external: true
  name: my-app-net
```




==========

Compose creates `[projectname]_networkname`







=================


https://docs.docker.com/compose/networking/

By default compose sets a single network.

Containers are available at hostnames as container names.

--project-name / COMPOSE_PROJECT_NAME

dir "myapp", network "myapp_default".

Overlay networks are always attachable.

`docker compose up` - old container is removed, new container joins
the network under a different IP, but the same name.
Connections to old container are closed, so containers which use this one,
should support reconnection.

links

custom networks: top-level networks key

# Configure default network:

```
networks:
  default:
    # Use a custom driver
    driver: custom-driver-1
```

# Pre-existing network
```
networks:
  default:
    external:
      name: my-pre-existing-network
```


