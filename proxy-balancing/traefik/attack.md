https://docs.docker.com/engine/security/#docker-daemon-attack-surface

Docker daemon works under root.

You can start container where /host dir is / on your host.

Check parameters which goes to docker API.

So API uses UNIX socket and not TCP socket.

Even if you close host from another hosts, the host vulnerable from
containers.

It is mandatory to secure API endpoints with HTTPS and certificates.
And make it reachable from restricted network, e.g. VPN.

DOCKER_HOST=ssh://USER@HOST

https://docs.docker.com/engine/security/https/

By default Docker run a non-networked unix socket.

Optionaly it can communicate over HTTP socket.
You can enable TLS by `tlsverify` and `tlscacert` flags.



=======================








