https://docs.docker.com/compose/compose-file/

YAML, defines: Services, Networks, Volumes.
yaml or yml.





${VARIABLE}

# build

## Path to the build context

```
build: ./dir
```

## Object

```
build:
  context: ./dir
  dockerfile: Dockerfile-alternate
  args:
    buildno: 1
```

This is ok:
```
build: ./dir
image: webapp:tag # such image will be created.
```

## Context

Path to dir or url to git repo.
```
build:
  context: ./dir
```

## dockerfile

Alternate dockerfile.

```
build:
  context: .
  dockerfile: Dockerfile-alternate
```

## ARGS

Set ARG in Dockerfile, and then:

Mapping:
```
build:
  context: .
  args:
    buildno: 1
    gitcommithash: cdc3b19
```
Or list
```
build:
  context: .
  args:
    - buildno=1
    - gitcommithash=cdc3b19
```

Or omited value:
```
args:
  - buildno
  - gitcommithash
```
So vars get from environment vars.


Bool values - strings: "true" / "false", "yes" / "no", "on" / "off".

## Cache from

Images for cache resolution.

```
build:
  context: .
  cache_from:
    - alpine:latest
    - corp/web_app:3.14
```

## Labels

```
build:
  context: .
  labels:
    com.example.description: "Accounting webapp"
    com.example.department: "Finance"
    com.example.label-with-empty-value: ""
```

## Network

https://docs.docker.com/compose/compose-file/#network
?? Network containers during build ??

## SHM_SIZE

## TARGET

Target in Dockerfile.

```
build:
  context: .
  target: prod
```

## CAP_ADD, CAP_DROP, CGROUP_PARENT.

## Command

Override default command.

## Configs

https://docs.docker.com/compose/compose-file/#configs
?? For swarm ??

## container_name

**!!!**
Must be unique.

## credential_spec

Windows only??

## depends_on

Starting and stopping services in dependency order.
Does not wait.

## deploy

For Swarm only.

## ENDPOINT_MODE
?? swarm

....

## devices

List of device mappings
(--device in docker)

```
devices:
  - "/dev/ttyUSB0:/dev/ttyUSB0"
```

## dns

Custom DNS servers.

```
dns: 8.8.8.8
```

```
dns:
  - 8.8.8.8
  - 9.9.9.9
```

## dns_search

Custom dns search domains

## entrypoint

## env_file

Single file or list of files.

Vars not automatically visible for build, so use build->args to introduce them.

Quotes passed to compose, vars are passed as is.





## ENVIRONMENT

Overrides vars from env_file section.

## EXPOSE

## external_links

## extra_hosts
--add-host

## healthcheck

## image

## init



## labels

## logging



## network_mode

## networks

## aliases

Alternative hostnames.

## IPV4_ADDRESS, IPV6_ADDRESS

Static IP for containers.

## pid

## ports

## restart

## secrets

## security_opt

Override default labeling scheme.

## stop_grace_period

(10 secs by default)

## stop_signal (SIGTERM by default)

## sysctls

## tmpfs

## ulimits

## userns_mode

## volumes

## CACHING OPTS FOR VOLUME MOUNTS
?? MAC

## domainname, hostname, ipc, mac_address, privileged, read_only, shm_size, stdin_open, tty, user, working_dir

## Variables substitution

${VARIABLE:-default} evaluates to default if VARIABLE is unset or empty in the environment.
${VARIABLE-default} evaluates to default only if VARIABLE is unset in the environment.

${VARIABLE:?err} exits with an error message containing err if VARIABLE is unset or empty in the environment.
${VARIABLE?err} exits with an error message containing err if VARIABLE is unset in the environment.

"$$VAR_NOT_INTERPOLATED_BY_COMPOSE"

Shell envs overrides .env envs.



## Extension fields

YML anchors and merge types.

```
version: '3.4'
x-logging:
  &default-logging
  options:
    max-size: '12m'
    max-file: '5'
  driver: json-file

services:
  web:
    image: myapp/web:latest
    logging: *default-logging
  db:
    image: mysql:latest
    logging: *default-logging
```

```
version: '3.4'
x-volumes:
  &default-volume
  driver: foobar-storage

services:
  web:
    image: myapp/web:latest
    volumes: ["vol1", "vol2", "vol3"]
volumes:
  vol1: *default-volume
  vol2:
    << : *default-volume
    name: volume02
  vol3:
    << : *default-volume
    driver: default
    name: volume-local
```





















