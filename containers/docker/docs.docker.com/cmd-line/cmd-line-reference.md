https://docs.docker.com/engine/reference/run/

`docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]`

* IMAGE - image to derive container from.


Image developer can define image defaults to:
* detached or foreground running.
* container identification.
* net settings.
* RT constrains on CPU and memory.

OPTIONS can override it.

`run` has more options then other commands.

========

# Operator exclusive options

Docker run can set following options:

## Detached (-d)

-d=true, or just -d

By default, containers started in detached mode exit, when the root process used to run the container exits.

If you use -d --rm - container is removed when it exits or when the daemon exits (which first).

Do not pass service xxx start to detached container.
Cause it senceless.

To input/output with detached containers, - use network or shared volumes.

docker attach - reattach detached container.

## Foreground

Console attached to the process standard input,output, err.

-a=[]: attach to stdin, stdout, stderr.
-t: allocate pseudo-tty.
--sig-proxy=true: proxy signals to the process.
-i: Keep stdin open, even if not attached.

`docker run -a stdin -a stdout -i -t ubuntu /bin/bash`

For interactive processes -i -t or -it.

-t is forbidden if stdin is pipe:
`echo test | docker run -i busybox cat`

Process with PID 1 inside container ignores standard signals unless
it is coded to handle them.

===========

# Container identification

--name

If you not assign --name - docker generates random string name.
Docker network can reference the container by its name.

Containers on the default bridge network must be linked to communicate by name.

# PID equivalent

--cidfile=""

# Image[:tag]

docker run ubuntu:14.04

# Image[@digest]

# --pid=""

PID namespace mode

https://engineering.remind.com/docker-image-digests/
https://success.docker.com/article/images-tagging-vs-digests

docker images --digests

'container:<name|id>'
'host':

for debug tools in container ??

# --uts

UNIX timesharing system.

nodename, domainname.

Container can have separate host and domain names.

'host' - the same UTS as on host.
--hostname and --domain name are invalid for 'host' UTS mode.

You can even change host name from a container.

# --ipc

Shared memory segments, semaphores, message queues.

* "" daemons default
* none (no /dev/shm mount)
* private
* shareable: possibility to share with other containers.
* container:<name-or-ID>: join another "shareable" container's namespace.
* host - host system IPC namespace.

Default can be 'private' or 'shareable'.

======

# Network settings

* --dns=[]: custom DNS servers for the container
* --network: connect container to a network
'bridge', 'none', 'container:name|id', 'host', 'network-name|network-id'
* --network-alias
* --add-host Add a line to /etc/hosts
* --mac-address (docker does not check it's uniquality)
* --ip=
* --ip6
* --link-local-ip

By default networking is enabled.

Container uses the same DNS as host. You can override this by --dns.

==========

# --restart

States: Up/Restarting

* no (default)
* on-failure:max-retries (non zero exit status) : 100, 200, 400 etc. ms.
* always (+daemon startup)
* unless-stopped

10 seconds run => success.

docker inspect shows number of attempts.

```
$ docker inspect -f "{{ .RestartCount }}" my-container
# 2
$ docker inspect -f "{{ .State.StartedAt }}" my-container
# 2015-03-04T23:47:07.691840179Z
```

=========

# Exit status

Chroot stardard.

docker run --foo busybox; echo $?

125 - docker daemon error.

126 - container command can not be invoked.

127 - container command can no be found.

=======

# --rm

By default container persists after container exists.
It is easy to debug.

But short-term foregroun processes could be removed right after run.

Also --rm removed anonymous volums.

Similar to `docker rm -v my-container`. Only containers w/o name are removed.

===========

# Security cfg

Labeling scheme.

Sharing content between containers.

user, role, type, level, disable, apparmor, no-new-pvivileges (disable su/sudo), seccomp-unconfined, seccomp.

=======

# --init

To indicate that init process will use PID = 1 in the container.

Default init is `docker-init` executable (included to default installation).

# --cgroup-parent

# Runtime constraints

-m - memory
--memory-swap = memory + swap
--memory-reservation - Memory soft limit.
--kernel-memory
-c, --cpu-shares=0 (relative weight)
--cpus=0.000
--cpu-period=0 (CFS (completely fair scheduler))
--cpuset-cpus
--cpuset-mems
--cpu-quota=0
--cpu-rt-period=0
--blkio-weigth=0
--blkio-weigth-device
--device-read-bps
--device-read-iops
--device-write-iops
-oom* (Out of Memory)
--memory-swappiness
--shm-size

kernel memory - no swaps.

================

# RT privilege and Linux capabilities:

--cap-add - add linux capabilities
--cap-drop - drop l c
--privileged - Give extended priveleges (SELinux and AppArmor features).
--device=[]: Allows to run devices inside container without --privileged flag.


By default docker containers are "unprivileged" and can not, e.g.,
run docker daemon inside container.
Cause by default container is not allowed to access any devices.

# Logging drivers

--log-driver=VALUE

* none (`docker logs` now available)
* json-file (default, no options supported)
* syslog
* journald
* gelf
* fluentd
* awslogs
* splunk

`docker logs` is availabeld for json-file and journald only.

# Overriding Dockerfile image defaults

Cannot be overriden:
* FROM, MAINTAINER, RUN, ADD

# CMD (default comman or options)

docker run [OPTS] IMAGE [`COMMAND`] [`ARG...`]

Overrides `CMD`

# --entrypoint

docker run -it --entrypoint /bin/bash example/redis

Rarely, but useful.

Also overrides `CMD`.

# PORTS

--expose: expose a port or a range of ports inside the container.

-P: publish all exposed ports to host interfaces.
-p: publish container's ports or range of ports to the host.
format: ip:hostPort:containerPort | IP::containerPort |
hostPort:containerPort | containerPort

-p 1234-1236:1234-1236/tcp

--link - add link to another container

`docker port` - find mapping.

# ENV

HOME
HOSTNAME
PATH
TERM (pseudo-tty)

docker run -e "deep=purple" -e today --rm alpine env

-h hostname

# HEALTHCHECK

--health-cmd
--health-interval and another params.

# TMPFS

`docker run -d --tmpfs /run:rw,noexec,nosuid,size=65536k my_image`

# VOLUME

-v, --volume:host-src:container-dest:opts

By default: rw.

rw, ro, z, Z

nocopy - to disable autocopying path from container to storage.
For named volumes `copy` is default mode.
Copy modes are not supported for bind-mounted.

*--volumes-from - mount all volumes from the given container.*

Some MountFlags in systemd unit, can prevent docker from changes detection.
And shared/rshared will not work.

container-dest must be abs. path.
host-src can be abs. path or name.

# USER

root (0) - default.

-u

# WORKDIR

default WORKDIR
`/` - by default.















































