https://docs.docker.com/config/containers/container-networking/

From container network is
* network interface with IP address.
* gw
* routing table
* DNS services
* other net details

# Published ports
By default - no ports.

--publish, -p - publish port outside

you can use it so:
-p 8080:80/tcp -p 8080:80/udp

By default container is assigned an IP address for every network it's connected to.

Docker daemon acts as DHCP server.
Each net has default subnet mask and gw.

docker run --network --ip=assignedIP

*Container's hostname defaults to the container's ID.*
You can override using --hostname.

docker network connect --alias aliasName for this network.

# DNS services

By default, container inherits DNS settings from host as define in
/etc/resolv.conf.
Default bridge copies /etc/resolv.conf from host to each container.

Containers with custom net use Docker's embedded DNS server, which
forwards estarnal DNS lookups to the DNS servers configured on the host.

Custom /etc/hosts is not inherited.
Use docker run --add-host (to add /etc/hosts)

--dns - IP address of a DNS server.

--dns-search To search non fully qualified hostnames.

--dns-opt (see OS's doc about resolv.conf valid opts)

--hostname - hostname for itself.
