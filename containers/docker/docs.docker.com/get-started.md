https://docs.docker.com/engine/docker-overview/

No hypervisor, better performance.

Easy to incorporate to any architecture (local, cloud, etc.).

Docker engine - client server app.
* Daemon (dockerd)
* REST API.
* CLI (docker), работает через REST API.

Forkwlow:

* Get image, test app in it (including auto- and manual tests),
deploy to client machine.

Docker client can use unix socket or network, and can comminicate with remote docker daemon.

Daemon manages: images, containers, networks, volumes.
? Can communicate to other daemons.

Docker registry - stores images.
Docker Hub - public registry.
By default docker looks up images on Docker Hub.

There is DDC (docker data center), it includes DTR (Docker Trusted Registry).

docker pull - from registry
docker push - to registry
docker run = docker pull + run.

# Images - read only templates. Often based on another image.
To build image - create Dockerfile.

Each instruction in Docker file creates layer.

# Containers
Runnable instance of image + cfg you given to it.
Can be started, stopped, moved, deleted.

You can connect container to one or more networks, attach storage to it,
create image based in current container state.

You can control how to isolate containers from other containers or host machine.

# docker run -it ubuntu /bin/bash - можно так запускать.

* docker pull ubuntu (if not have it locally)
* docker container create
* rw fs creation  (in /var/lib/docker?)
* network interface creation. Включает назначение IP адреса контейнеру.
By default container can connect to external networks using host machine network.
* starts container and execute /bin/bash
* Whey you type 'exit' to terminate /bin/bash - container stops, but is not removed.
It could be started again.

# Services (swarm ?)

Allow you to scale containers across multiple docker daemons
which work together with multiple managers and workers.
Daemons communicate using Docker API.
Allows to define number of replicas.
By default service is load-balanced across all worker nodes.
To the consumer - service is a single app.


# Techs
Golang + Linux kernel

# Namespaces
pid, net, ipc, mnt, uts (Unix Timesharing System)

# Control Groups

Limits app to some set of resources.

# UnionFS

# Container format (default libcontainer)



















