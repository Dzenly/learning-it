https://docs.docker.com/engine/reference/commandline/cli/

docker help

There is /root/.docker config.

-l, --log-level string   Set the logging level ("debug"|"info"|"warn"|"error"|"fatal") (default "info")

* DOCKER_CONFIG
* DOCKER_CLI_EXPERIMENTAL
* DOCKER_HOST Daemon socket to connect to.
* DOCKER_HIDE_LEGACY_COMMANDS
* DOCKER_TMPDIR

GO Vars:
* HTTP_PROXY
* HTTPS_PROXY
* NO_PROXY

# Configs

directory called .docker within your $HOME directory.

config.json file to control certain aspects of how the docker command behaves.

=========

## attach (input, output, errors)

Displays output of ENRYPOINT/CMD.

CTRL + c sends SIGINT by default (--sig-proxy=true)

-it CTRL+P CTRL+q - to detach and leave running.

PID1 does not receive signals unless especially handles it.

1 MB buffer.

Too much spam will decrease performance.
Use `docker logs` instead.

Returns exit code.

=============

## build

`docker build [OPTIONS] PATH | URL | - `

* PATH | URL | - : *docker context*
### URL:

#### Git repo
saved in tmp and can be accessed by docker farm users.
`docker build https://github.com/docker/rootfs.git#container:docker`
branchOrTag:Subdirectory

#### Tarball

* tarball
* plain text files

==============

### Options

--add-host
--build-arg : build time vars
--cache-from: images consider as cache sources

https://medium.com/@gajus/making-docker-in-docker-builds-x2-faster-using-docker-cache-from-option-c01febd8ef84

As I understand this is actual for DIND like envs, to get caches from repo.

--cpu*
-f, --file - name of Dockerfile, default is PATH/Dockerfile.
--force-rm - remove intermediate containers.
--iidfile - *Write image id to thefile*
--label
--memory*
--network
--no-cache
--progress ?
--pull (for newer version)
-q, --quited (just print image id on success)
--rm : remove intermediate container.
--secret: for BuildKit, secret file to expose to the build.
--security-opt ?
--shm-size
--squash (experimental)
--ssh (only for BuildKit)
--tag, -t: name:tag
--target : target build stage.
--ulimit

### Build with PATH

Build context is tar'ed ?

Dockerfile is parsed on server side of docker daemon.

Intermediate images by default removed.
There is images and there is cache.
--rm=true removes images, but keeps cache.

### Build with URL

`docker build github.com/creack/docker-firefox`

`docker build -f ctx/Dockerfile http://server/ctx.tar.gz`


### .dockerignore

.git

BuildKit myapp.Dockerfile.dockerignore

### -t name:tag/version

You can apply multiple tags.

### -f

if -
read Dockerfile from stdin.

### cgroup, ulimit

### build-arg

w/o value - ENV will set from environment.

### --add-host

## --target

After target command are skipped.

### --output, -o

For BuildKit only.

CSV formatted string.
* local: dir on client
* tar

docker build --output type=local,dest=out .

docker build --output type=tar,dest=out.tar .

### External cache

--build-arg BUILDKIT_INLINE_CACHE=1

If cache hit, image is pulled from registry.
(json file to keep hashes)

This can be useful if there are many builders on different hosts.

### Squash (experimental)

=============


* builder
* buildx

# commit
Commit container's diffs to another image.

* *container*

* *cp*

* create : as run, but without start

* *diff*

* *events*

# exec

-d, --detach

--env
-i
-t
--user
--workdir

# *export*

--output

No volumes at export. Even if they are mounted.

* *history*

* image
* images

* *import*
* *info*


* *inspect*

* kill
* load
* login
* logout
* logs ?
* manifest ?
* **network**


* node (swarm)
* pause

* plugin ?
https://docs.docker.com/engine/extend/

* *port*

* ps

* pull/ push
* rename
* restart
* rm
* rmi
* run
* save
* search (hub)

# secret (swarm only ?)

* service
* stack ?
* start



* *stats* ! (resource usages)

* stop
* swarm

* *system*

* tag

e.g. for private repo:
`docker tag 0e5574283393 myregistryhost:5000/fedora/httpd:version1.0`



* *top*

* trust
* unpause

* *update* - dynamically correct resources for container.


* version

# volume

## docker volume create OPTIONS VOLUME

--driver (default: local)
--label
--name
--opt (as for mount command)

name must be unique

```
docker volume create --driver local \
    --opt type=tmpfs \
    --opt device=tmpfs \
    --opt o=size=100m,uid=1000 \
    foo
```

## inspect, ls, prune, rm.


* wait (wait for container to stop)




