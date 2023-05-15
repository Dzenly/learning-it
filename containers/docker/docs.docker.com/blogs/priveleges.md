https://www.docker.com/blog/docker-can-now-run-within-docker/

docker run -privileged -t -i jpetazzo/dind

dind

LXC, iptables, ca-certificates

For dind, the place where inner docker stores its container can not be AUFS system.

So this path /var/lib/docker should be volume.

docker run -privileged -d -p 1234 -e PORT=1234 jpetazzo/dind

docker inspect - shows public port allocated for container.

==================



