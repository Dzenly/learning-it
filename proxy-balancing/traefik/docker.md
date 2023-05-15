https://doc.traefik.io/traefik/providers/docker/


Docker standalone and docker swarm - ok.

```yaml
version: "3"
services:
  my-container:
    # ...
    labels:
      - traefik.http.routers.my-container.rule=Host(`example.com`)
```

Retrieves private IP and port of containers from Docker API.

* If container exposes only one port - Traefik uses this port
for priv communication.

* If a container exposes many or 0 ports, you must
manually specify port by

`traefik.http.services.service_name.loadbalancer.server.port.`

# For host networking

* try a lookup of host.docker.internal
* fall back to 127.0.0.1

**Security concert** - Accessing docker socket without any restrictions.

Only trusted users can be in docker group.

AAA (authentication, Authorization, Accounting).

https://doc.traefik.io/traefik/providers/docker/#provider-configuration

```yaml
providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"

# Or so:
providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
```
useBindPortIP: true - использовать забинденные IP/PORT, а не внутренние.
Если есть.
В том числе работае и на
`traefik.http.services.<name>.loadbalancer.server.port`
Только фолбечит на внутренний IP а порт юзает указанный.


```
docker container port *insert container_uuid*
80/tcp -> 0.0.0.0:32768
```

exposedByDefault (default: true)

*network (default: empty)*
To override use `traefik.docker.network label`

*defaultRule (default: Host(`{{normalize .Name }}`))*

Valid Go template + sprig template functions.
https://golang.org/pkg/text/template/
http://masterminds.github.io/sprig/

Template has access to all labels defined in container.

constrains - whether to create routes for container.

Label(key, value), LabelRegex(key,value)
`!` for negation.

https://doc.traefik.io/traefik/routing/providers/docker/

Enabling docker provider:

```yaml
providers:
  docker: {}
```

docker-compose:
```yaml
version: "3"
services:
  my-container:
    # ...
    labels:
      - traefik.http.routers.my-container.rule=Host(`example.com`)
```

Traefik creates for each container corresponding service and router.

Labels are case insensitive.

service can be assigned to one or several routes.

If label defines a router (through router rule), and label defines
a service (through loadbalancer), but the router does not specify any
service, then this service will be automatically assigned to the router.

If a label defines a router, but no service is defined,
service is auto-created and assigned to the router.

Т.е. я так понял, можно связывать один роут с несколькими сервисами,
как раз для баланса нагрузки.

https://doc.traefik.io/traefik/routing/providers/docker/#routers

```
# myrouter - arbitrary name.
"traefik.http.routers.my-container.rule=Host(`example.com`)"

#entry points. You can filter them.
"traefik.http.routers.myrouter.entrypoints=ep1,ep2"

"traefik.http.routers.myrouter.middlewares=auth,prefix,cb"

"traefik.http.routers.myrouter.service=myservice"

# tls: true - current router is for tls only.

# куча других tls настроек.

# priority тоже можно задавать.

```

https://doc.traefik.io/traefik/routing/providers/docker/#services

```
# useful when container exposes multiple ports.
- "traefik.http.services.myservice.loadbalancer.server.port=8080"

traefik.http.services.<service_name>.loadbalancer.passhostheader

# health check options.

# sticky cookies
- "traefik.http.services.myservice.loadbalancer.sticky.cookie=true"

# Порции, которыми траефик отдает данные. "traefik.http.services.myservice.loadbalancer.responseforwarding.flushinterval=10"

```

Мидлварями можно редиректить:

```
# Declaring a middleware
         - traefik.http.middlewares.my-redirect.redirectscheme.scheme=https
```

https://doc.traefik.io/traefik/routing/providers/docker/#specific-provider-options

`- "traefik.enable=true/false"`
Можно убирать контейнер из траефика.
This option overrides the value of exposedByDefault

`- "traefik.docker.network=mynetwork"`

Name is mandatory, otherwise - it will be picked randomly.



























https://doc.traefik.io/traefik/routing/providers/docker/

