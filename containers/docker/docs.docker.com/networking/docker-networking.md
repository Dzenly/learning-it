https://docs.docker.com/network/

Приложениям в докере не надо знать, что они в докере.

This article is not Not about iptables manipulation.

Drivers:

* bridge (default). Обычно юзается, когда приложения работают
в отдельных контейнерах, которым нужно общаться.

* host -remove net isolation between container and the docker host.
And use host's networking directly.
Only available for swarm.

* Overlay. When containers run on different docker daemons.
This strategy replaces OS level routing.

* macvlan
Container has MAC and looks like physical device in your net.
?For legacy apps?

* none (disable all net). Not available for nets devices.

* net plugins. Any third party plugins.

https://docs.docker.com/network/bridge/

Бридж в докере - софтварное соединение нескольких машин, находящихся на одном докер хосте,
так что машины в одном бридже могут общаться друг с другом,
и не могут общаться с машинами вне бриджа.

Чтобы общаться с другими хостами - нужно либо overlay network, либо
настраивать маршруты на уровне OS.

По умолчанию при старте докер сервиса создается
дефолтный мост (bridge), и все новые контейнеры подключаются к нему.

Можно создавать user defined bridge networks.

User Defined Bridge vs Default Bridge

* DB - only IPS (--link is legacy, править /etc/hosts - гемор при отладке). UDB - aliases and DNS.
Типа удобно, контейнер переносишь, а имя сохраняется.

* UDB - better isolation. --network creates scope.

* You can attach/detach container to UD networks on the fly.
DB - you can only stop container and recreate it with different network opts.

* You can configure default bridge. But configs will be common for all containers. Also after configuration containers must be restarted.
docker network create allows to create configs for some group of apps.

* Шарить переменные через флаг --link для UDN не получится. Тогда шарить так:
- Монтировать файл или папку, с shared info, с использованием docker volume.
- docker-compose, + переменные в файле docker-compose.yml
- swarm + shared configs and secrets.

=======

# User defined bridge managing:

docker network create my-net
subnet, ip address range, gateway and other opts.

docker network rm - for remove UDB.
Disconnect containers before this.

======

Note: on linux bridges are managed by iptables. But you should not care about this.

==========

# Connect a container to UDB

`docker create --name my-nginx --network my-net --publish 8080:80 nginx:latest`

For connect/disconnect a running container:
`docker network connect/disconnect my-net my-nginx`

Поддерживается ipv6.

=============

# Enable forwarding from Docker to outside world

By default disabled.

Configure the Linux kernel to allow IP forwarding.
sysctl net.ipv4.conf.all.forwarding=1

sudo iptables -P FORWARD ACCEPT

These settings do not persist across a reboot, so you may need to add them to a start-up script.

======

Default bridge is not recommended for prod.

=========

Configure default bridge net in daemon.json.
Don't forget to restart docker.

==========================
==========================
==========================

https://docs.docker.com/network/overlay/

can be encrypted.

==========================
==========================
==========================

https://docs.docker.com/network/host/

No its own IP for container.
Used for optimize performance.

==========================
==========================
==========================

https://docs.docker.com/network/network-tutorial-standalone/

(without swarm)

docker network ls

docker image ls
docker container ls
docker network inspect bridge
ip addr show

Ctrl+p  +   Ctrl+q - выйти из интерактивного контейнера.

Можно подсоединять к нескольким сетям, через docker network connect.
docker run позволяет указыавть в --network только одну сеть.

==========

UDN дает Automatic Service Discovery.

============
============
============

https://docs.docker.com/network/iptables/

По идее Docker сам рулит твоими iptables, но нужно знать некоторые
неявные моменты, если хочется вручную что-то настроить.

Эта дока про то, как регулировать доступ к твоим контейнерам извне.

Docker installs 2 custom iptables chains: DOCKER-USER, DOCKER
and filters incoming packets by them.

DOCKER chain - Docker's iptables rules.

DOCKER-USER chain loads before DOCKER chain.

FORWARD chains are evaluated after DOCKER, DOCKER-USER chains.

# Restrict connections to the Docker host.

By default all external IPs are allowed to the Docker host.
To restrict IPs - correct DOCKER-USER chain.

To open net from 192.168.1.1:
`iptables -I DOCKER-USER -i ext_if ! -s 192.168.1.1 -j DROP`

For subnet:
`iptables -I DOCKER-USER -i ext_if ! -s 192.168.1.0/24 -j DROP`

For range:
`iptables -I DOCKER-USER -m iprange -i ext_if ! --src-range 192.168.1.1-192.168.1.3 -j DROP`

https://www.netfilter.org/documentation/HOWTO/NAT-HOWTO.html

# Docker on a router

iptables -I DOCKER-USER -i src_if -o dst_if -j ACCEPT

# Prevent docker from iptables.

пока мне не нужно.

# Setting the default bind address

By default it is 0.0.0.0.
--ip options - changes default. But only default.

================

https://docs.docker.com/config/containers/container-networking/

From the container's point of view, it has net interface with IP address,
gateway, routing table, DNS services, and other network details.

# Published ports

By default - no ports are published.

-p docker-host-port:port-in-container
-p 192.168.1.100:8080:8
-p 8080:80/ud
-p 8080:80/tcp -p 8080:80/udp

Docker daemon acts as a DHCP server for each container.
By default the container is assigned an IP address for every Docker
network it connected to.
Each network has a default subnet mask and gateway.

at container start you can specify IP by --ip or --ipv6

--hostname
--alias

By default hostname is container id.

# DNS

By default container inherits Docker daemon's settings, including /etc/hosts
and /etc/resolv.conf

--dns - specifies ip of DNS, can be use many times.
--dns-search
--dns-opt
--hostname

https://docs.docker.com/network/proxy/

~/.docker/config.json

























*
