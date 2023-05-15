https://docs.docker.com/engine/reference/commandline/network_create/

`docker network create [OPTS] NETWORK`

driver: bridge (default) or overlay.

docker0 bridge - auto-created by docker at installation.
*bridge* network corresponds to *docker0* bridge.

docker run wo params connects to *bridge*.

You can not remove default bridge network, but you can create new network.

Bridge - one host (single Docker engine).


Multiple docker hosts - overlay.

--attachable - manual container attachment

--aux-address - (только для macvlan ??)

--config-from - (another network to copy cfg from)

--config-only - cfg only network

--driver, -d

--gateway - gw to master subnet.

--internal - restrict external access

--ip-range - sub range to allocate container IP.

--ipam-driver
--ipam-opt
--ipv6
--label - metadata on network
--opt, -o - Driver specific options.
--scope ?? control network scope

--subnet - CIDR for network segment.

========

## Connect containers

docker run --network=netname imagename

docker network connect - to add running container to a network.
docker network disconnect

## Specify advanced opts

At net creation Engine creates non-overlapping subnetwork.

===============

## Bridge driver opts

```
docker network create \
   -o "com.docker.network.bridge.host_binding_ipv4"="172.19.0.1" \
   simple-network
```

com.docker.network.

bridge.name
bridge.enable_ip_masquerade (--ip-masq)
bridge.enable_icc (--icc)
bridge.host_binding_ipv4 (--ip) ??
driver.mtu (--mtu)
container_interface_prefix (custom prefix for container interfaces)


docker network
* connect
* create
* disconnect
* inspect
* ls
* prune
* rm

https://docs.docker.com/network/bridge/

Bridge net is a link layer device which forwards traffic between network segments.

IPTABLES ?? Set so as containers from the same bridge can communicate to each other and containers from anoher bridge can not.

========

UD bridges provide auomatic DNS reslution between containers, but name or alias.

On default net you would use --link (deprecated) for both containers.

Connect/disconnect to custom network on the fly.
But for default network - only via restart.

If you need to share env vars - mount file or dir with env.
compose file can define shared vars.

Containers expose all ports for each other.

*By default trafic is not forwarded to outside world.*

To allow:

sysctl net.ipv4.conf.all.forwarding=1
sudo iptables -P FORWARD ACCEPT
(reset on reboot)














