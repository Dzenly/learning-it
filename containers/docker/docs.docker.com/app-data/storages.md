https://docs.docker.com/storage/

By default data created inside container is stored on a writable
container layer.


* data removed when container removed.
* containers writable layer is coupled with host. You can't easily
move the data somewhere else.
* writting to WL requires storage driver. Storage driver provides UFS,
using Linux kernel. *This kills performance.*
**Довод, чтобы не делать бд в докер контейнере**
*Делать для этого volume, который типа будет юзаться несколькими PG, тоже не вариант*.

# Opts to store files:

`--mount`

## Volumes

Part of Host FS which is managed by Docker.
/var/lib/docker/volumes
Non-docker processes should not modify it.
*The best way to persist data in Docker.*

Created by Docker.
You can use `docker volume create`, or docker can create volume during container or service creation.

A volume can be mounted into many containers.

docker volume prune - removes Volume.

Can be *named* or *anonymous* (random name, unique for the host).

Volumes support volume drivers (remote hosts or even clouds).

Removed when you explicitly remove them.

```
docker run -d \
  --name devtest \
  --mount source=myvol2,target=/app \
  nginx:latest
```


### Good cases

* Sharing data among multiple containers.
* Uniform container for different Docker hosts. No bind to directories structure.
* Remote host or clouds.
* You can migrate volumes. I.e. stop container and move directory
(/var/lib/docker/volumes/<vol-name>).

## Bind mounts

Anywhere on host system. Can be modified by container and other processes.

```
docker run -d \
  -it \
  --name devtest \
  --mount type=bind,source="$(pwd)"/target,target=/app \
  nginx:latest
```

Full path.
Creates on demand if it does ot exist.
Very performant.
Requires certain directory structure on the host.
Consider to use named volumes instead.
Docker CLI does not work with bind mounts.

Since Bind mounts files can be changed from container,
you need to think about security.

### Good cases

* Sharing cfg files between host and containers.
E.g. /etc/resolv.conf.

* Sharing source code and build artifacts bw dev env and containers.
You can update this artifacts when you need it.
For prod you need to copy prod ready artifacts to image.

* When you have guaranteed fs structure on the Docker host.

## Tmpfs mount

Not persisted on disk. Used by container during the runtime.
E.g. swarm keeps secrets in tmpfs.

### Good cases

* Security artefacts.
* Performance.
* Large volume of non-persistent data.

==========

# Tips

* If you mount an empty volume into a directory in the container in which
files and directories exist, these files and dirs
are copied into the volume.
* If you start a container and specify non-existing volume, it will be created.
*So you can prepopulate date from existing containers to newly created ones*

* If you mount bind mount or non-empty volume. Existing files are hidden, until unmount.





