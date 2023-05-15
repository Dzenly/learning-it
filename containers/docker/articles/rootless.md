https://docs.docker.com/engine/security/rootless/

Executes docker daemon inside user namespace.

newuidmap
newgidmap

dockerd-rootless-setuptool.sh in /usr/bin.

systemctl --user start docker

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock


`docker run -d --name dind-rootless --privileged docker:20.10-dind-rootless`





