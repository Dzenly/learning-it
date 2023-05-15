https://doc.traefik.io/traefik/routing/overview/

Entrypoint - port number [+ UDP].

Routers - analyze if incomming requests match a set of rules.

Then middlewares.

Then to your services.

Providers - discover services (IP, health, etc.)

Entrypoints - listen to incomming traffic.

Routers - analyze requests (host, path, headers, SSL, ...)

Middlewares - may update the request (authentication, rate limitation, headers..)

Services - forward requests to your services (load balancing).


**serversTransport** - what happens between traefik and backend.

```yaml
## Static configuration
serversTransport:
  insecureSkipVerify: true

## Static configuration
serversTransport:
  rootCAs:
    - foo.crt
    - bar.crt
```

https://doc.traefik.io/traefik/routing/entrypoints/

web, websecure, streaming,

transport

X-Forwarded-For.

https://doc.traefik.io/traefik/routing/routers/

Can use middlewares.

```yaml
http:
  routers:
    my-router:
      rule: ""
      service: ""

```

By default http routers will accept requests to all defined entry points.

# Rule (before middlewares and services)

(), ||, &&, regexps, and functions.

Host, Headers, Path, Query.

Arbitrary variable + regexp.
https://golang.org/pkg/regexp/

E.g. `/posts/{id:[0-9]+}`

*Longest rule length*
priority.

# Middlewares

Before service.

Order - as they declared in routes.

# Service

нельзя юзать `@` в имени.

HTTP routers only target HTTP services (not TCP ones).

## TCP

Apply before HTTP routes.


## UDP

Just load balancers

https://doc.traefik.io/traefik/routing/services/


```yaml
http:
  services:
    my-service:
      loadBalancer:
        servers:
        - url: "http://<private-ip-server-1>:<private-port-server-1>/"
        - url: "http://<private-ip-server-2>:<private-port-server-2>/"
```

Only round robin load balancing is supported.

# Sticky sessions

When enabled - cookie is set on init request and response
to let the client which server handles first response.

Client resent the same cookie, requrest goes to the same server.

For complex hierarchy - cookie have as many key/val pairs as there are sticky levels.

# Health check

# PASS Host Header

=========================

















