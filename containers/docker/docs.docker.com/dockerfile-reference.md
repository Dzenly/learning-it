https://docs.docker.com/engine/reference/builder/

docker image build [OPTIONS] PATH | URL -



PATH - local directory.
URL - git repository.

docker build -f myOwnDockerfile

Для сохранения в репозиторий:
docker build -t shykes/myapp .

Before Dockerfile execution - syntax check.

?? The Docker daemon will automatically clean up the context you sent.

Each instruction is run independently and creates a new image.
Say `RUN cd /tmp` does not affect next instructions.

docker load - loads the whole chain.

?? `--cache-from` do not need to have a parent chain
and may be pulled from another registries ??

# BuildKit

DOCKER_BUILDKIT=1

* Parallel build independent build stages
* Incrementally transfer only changed files in your BC
* Detect and skip unused files from BC
* external Dockerfile implementations
* Avoid side effects with rest of the API (intermediate images and containers)
* Prioritize build cache for automatic pruning.

======

*Instructions are not case sensitive* UPPERCASE is just a convention.

Dockerfile must begin with *FROM* instruction, which specifies parent image.
It can be after `parser directives`, `comments`, `globally scoped ARGs`.

Line continuation is not supported in comments.

# Parser directives

It is a special type of comment.

Do not add layers to the build, and do not show as build step.

?? A single directive can be used once.

*Parsed only at very top of Dockerfile*

Non case sensitive, lowercase is a convention.
Use blank line after parser directives.

Spaces are ignored in directives.

## syntax (only for BuildKit)

`# syntax=docker/dockerfile`
`# syntax=example.com/user/repo:tag@sha256:abcdef...`

* The same builder for all builds.
* Latest features and fixes without update docker daemon.

Semver

docker/dockerfile:1.0.0 - only allow immutable version 1.0.0
docker/dockerfile:1.0 - allow versions 1.0.*
docker/dockerfile:1 - allow versions 1..
docker/dockerfile:latest - latest release on stable channel


## escape

default
# escape=\ (backslash)
alternative

```
# escape=` (backtick)
```

Escapes character in line, and newline.
For RUN commands escape works only at the EOL.

backtick is useful for Windows, where slash is dir separator.


# Environment replacement

ENV statement.

${foo}_bar

$var
${var}

${variable:-word} - if not set - word
${variable:+word} - if set - word

Following list of instructions support variables:

* ADD
* COPY
* ENV
* EXPOSE
* FROM
* LABEL
* STOPSIGNAL
* USER
* VOLUME
* WORKDIR
* ONBUILD (with one of the above instructions)

=======

env var calculated before instruction execution.
If you change env var in instruction, changes will affect only the next instruction.

=======

# .dockerignore

Similar to file globs on UNIX.
Files removed from context and can not be used in ADD/COPY.

/foo/bar - будет игнорить PATH/foo/bar
or URL/foo/bar.

`*`
`?`

!

Go's filepath.Match + `**` (zero or more directories)

Last line with pattern - determines behaviour.

`*` - в начале, и дальше куча `!` и получится white list.

pattern `.` is ignored.

# FROM

FROM [--platform=<platform] <image>[:tag | @<digest>] [AS <name>]

Initializes a new *build stage*.
Sets Base image.

`ARG` - the only instruction that my precede `FROM`.

FROM can appear multiple times, to create multiple images or
or use one build stage as dependency for another.

FROM clears states created by prev instructions.

<name> can be used in subsequent FROM and COPY --from=<name|index>.

* if tag or digest are omited "latest" implyed.

## ARG and FROM

ARG before *the first* FROM can be used in all FROM instructions.

Если хочешь юзать ARG после FROM, - подключи его декларацию (без присваивания)

```
ARG VERSION=latest
FROM busybox:$VERSION
ARG VERSION
RUN echo $VERSION > image_version
```
===============

# RUN

2 forms:

* RUN <command> (shell form, /bin/sh -c)
* RUN ["executable", "param1", "param2"] (exec form)

RUN выполняет команду в новом слое, и коммитит новый образ.
Этот образ будет юзаться в следующих шагах Dockerfile.

Containers can be created from any point of images history,
a bit like in VCS.

Exec form allows to run commands when shell is absent.

Default shell is changed using SHELL command.

You can use backslash to continue line.

```
RUN /bin/bash -c 'source $HOME/.bashrc; \
echo $HOME'
```

```
# To use another shell, you can use exec form.
RUN ["/bin/bash", "-c", "echo hello"]
```

Double quotes, not single ones.

In exec form there is no env vars substitution.
But if you use shell in exec - shell will do vars substition.

In JSON form it is necessary to escape backslashes.

*The cache for RUN isn't invalidated automatically during the next build*.

`RUN apt-get dist-upgrade -y` will be reused during the next build.

docker build --no-cache - invalidates cashes for all RUN instructions.

Caches for RUN can be invalidated by ADD (see below)

There is issues with AUFS.

===============

# CMD

Provides defaults for container execution.

3 forms

* CMD ["executable", "param1", "param2"] (preferred form)
* CMD ["param1, "param2" ] (default parameter for ENTRYPOINT, so ENTRYPOINT is the mandatory in this case)
* CMD command param1, param2 (shell form, /bin/sh -c)

Only one CMD (the last one) is used.

Environment substitution as for RUN command.

Arguments in `docker run` override ones specified by CMD.

RUN - is for build time. CMD is for run time.

=================

# LABEL

`LABEL <key>=<value> <key>=<value> ... `

Adds metadata to image.
To include space - use quotes and backslashes.

```
LABEL "com.example.vendor"="ACME Incorporated"
LABEL com.example.label-with-value="foo"
LABEL version="1.0"
LABEL description="This text illustrates \
that label-values can span multiple lines."
```

labels are inherited.

and can be overriden.

`docker inspect` - shows labels.

# MAINTAINER (deprecated)

Use `LABEL maintainer=""` instead.

===============

# EXPOSE

`EXPOSE <port> [<port>/<protocol>]` by default TCP.

This is just documentation.
To publish the port you should use `-p` flag for `docker run`.
OR `-P` flag to publish all exposed ports.

To expose both TCP and UDP, include two lines:
```
EXPOSE 80/tcp
EXPOSE 80/udp
```

`-p` can override EXPOSE.

`docker run -p 80:80/tcp -p 80:80/udp`

`docker network` support creation of networks for communication
among containers without need to expose or publish specific ports.
Because containers of one network can communicate with each other
by any port.

===============

# ENV

Persistent for all subsequent instructions, run time also.

`docker --env` - to change.
`docker inspect` - view.

`ENV key value` # single variable
`ENV key=value`



```
ENV myName="John Doe" myDog=Rex\ The\ Dog \
    myCat=fluffy
and

ENV myName John Doe
ENV myDog Rex The Dog
ENV myCat fluffy
```

===============

# ADD

Copies new files, directories or remote file URLs from <src>
and adds them to the image at the <dest>.

if src are files or dirs, paths are relative to build context.

<src> may contain filepath.Match rules.
https://golang.org/pkg/path/filepath/#Match

`ADD [--chown=user:group] src... dest`
`ADD [--chown=user:group] "src", ... dest` (for paths containing whitespaces).

<dest> is absolute path (starting with `/`) or path relative to WORKDIR.

By default UID and GID 0.

user:group can be integers also.

In case of URL, the destination will have 600 permissions.
HTTP Last-Modified will be used to set mtime.
But mtime will not determine if cache should be updated.

`docker build - < some file` has no build context, so
Dockerfile can contain only URL based `ADD`.
If some file is archive and contains Dockerfile in root,
this Dockerfile' dir will be used as build context.

ADD do not supprt authentication, so you have to use `RUN wget ...`.

The first encountered `ADD` will invalidate cache for all following
instructions if contents of <src> have changed, including `RUN`.

Rules:

* src must be inside build context. you cannot ADD ../
* if dst is directory, the entiry contents of the dir is copied, including
metadata. The dir itself is not copied.

IF src is url
* if dst ends with slash - file path will be as in url.
* otherwise - url path ignored.

* if src is local tar arc in known format, it is unpacked as a directory.
Resources from URLs are not decompressed. If file exists it it overwritten.

compression format is detected from file content, not from name.

?? Если есть слеш `dst/`, и src - простой файл - его путь игнорится.

If dest does not end with slash, it is considered as regular file,
and content of src will be written to dest.

If dest does not exist, it is created with all missing directories.

===============

# COPY

Differences from ADD:
* No URLs support
* So Build context is mandatory, no stdin support.
* --from option. If there is no such stage name - image name will be searched.

===============

# ENTRYPOINT

`ENTRYPOINT ["executable", "param1", "param2"]` (exec form, preferred)
`ENTRYPOINT command param1 param2` (shell form)

`docker run image arg1 arg2` - arg1,arg2 will be appended to
args of exec form. Also arg1, arg2 will override CMD's arguments.

`docker run --entrypoint` - overrides ENTRYPOINT, but in exec form.

**!!!**
В `/bin/sh -c` не пробрасываются сигналы.
Т.е. docker stop не долетит до экзешника.

*Shell form prevents usage arguments from CMD or `docker run`*.

If there is few ENTRYPOINT - last one will take effect.


Хорошая практика:

```
FROM ubuntu
ENTRYPOINT ["top", "-b"] # Stable part.
CMD ["-c"] # default values for variable part, also overriden in docker run.
```

===

To catch signals in shell mode, use exec.

```
FROM ubuntu
ENTRYPOINT exec top -b
```

Exec form ENTRYPOINT and shell form of CMD gives strage result
`exec_entry p1_entry /bin/sh -c exec_cmd p1_cmd`

ENTRYPOINT don't use inherited CMD.

===============

# VOLUME

VOLUME ["/var/log", ...]
VOLUME /var/log /var/db

docker run initializes newly created volume with data which
exists in specified location in image.

**If build step changes the data after VOLUME declaration -
changes will be discarded.**

Host директория создается в run-time.
And it is host dependent.
You can't mount host dir within Dockerfile.
VOLUME does not support specifying host-dir.
*You must specify mountpoint when you create or run the container*

===============

# USER

USER user:group

User for commands: RUN, CMD, ENTRYPOINT.

When the user have not primary group, root group will be used.

===============

# WORKDIR

WORKDIR /path/to/workdir

CWD for: RUN, CMD, ENTRYPOINT, COPY, ADD.
If the dir does not exist, it will be created.

WORKDIR can be used multiple times.
Relative paths are relative to previous WORKDIR.

?? What is WORKDIR by default?

Env vars are supported:

```
ENV DIRPATH /path
WORKDIR $DIRPATH/$DIRNAME
```




===============

# ARG

`ARG <name>[=<default value>]`

`docker build --build-arg <varname>=<value>`

Warning if argument is not defined in Dockerfile.

Не рекомендуется передавать секретные данные через ARG,
cause it can be displayed by `docker history`.

## Scope

1 FROM busybox
2 USER ${user:-some_user} # Здесь ещё переменная user отсутствует, поэтому some_user
3 ARG user
4 USER $user # А здесь уже присутствует, поэтому то, что передали в docker build --build-arg user=<>.

ARG becomes invisible in next build stage.
So you need defined it.

```
FROM busybox
ARG SETTINGS
RUN ./run/setup $SETTINGS

FROM busybox
ARG SETTINGS
RUN ./run/other $SETTINGS
```

## Using ARG vars

ENV overrides ARG

As in shell script locally var overrides cmd line var.
(from the point of definition)

*ENV is always persistedin the build image.*
*ARG is persisted at build stages only*

## Predefined ARGs

* HTTP_PROXY
* http_proxy
* HTTPS_PROXY
* https_proxy
* FTP_PROXY
* - "" -
* NO_PROXY
* - "" -

So you can use them in --build-arg

By default they are excluded from docker history
and are not cached.

So, no cache miss at these params changing
?? И что это значит ??
?? То, что билд не перезапустится, и возьмется старый образ ??

Чтобы попадать  историю и в кэш, нужно юзать ARG для этих переменных тоже.

## Automatic platform ARGs in the global scope

*Only for Buildkit*.

Build platform, target platform (--platform).

* TARGETPLATFORM (linux/amd64)
* TARGETOS
* TARGETARCH
* TARGETVARIANT
* BUILDPLATFORM
* BUILDOS
* BUILDARCH
* BUILVARIANT

To expose - use
```
FROM alpine
ARG TARGETPLATFORM
RUN echo $TARGETPLATFORM
```
## Impact on build caching

Though ARG are not persisted into the built images, they do impact
the build cache.
If Dockerfile defines ARG var which is different from a prev build,
"cache miss" occurs upon its first usage (not definition).

All predefined ARG vars do not affect caching unless mentioned
in ARG.

Если ты переопределил переменную через константную ENV -
кэш промахов не будет.

================

# ONBUILD

trigger to be executed when image is used as base, right after FROM.

Any build instructions can be registered as trigger.

Inherited only once, i.e. do not run on grand children.

These instructions are not allowed: ONBUILD, FROM, MAINTAINER.

Example - build machine.

================

# STOPSIGNAL

STOPSIGNAL signal

Signall to be sent to the container to exit.

================

# HEALTHCHECK

* HEALTHCHECK [OPTIONS] CMD command
* HEALTHCHECK NONE (disable healthchecks from base image )

If specified - container has *health status*.

* starting
* healthy
* unhealthy

--interval=DURATION (default: 30s)
--timeout=DURATION (default: 30s)
--start-period=DURATION (default: 0s)
--retries=N (default: 3)

* Container started
* 1: `interval` seconds
* healthcheck
* goto 1;

if check lasts more that `timeout` it is considered as failed.

After `retries` count container is considered as unhealthy.

`start period` - Period when retry counter is not incremented.

Only one HEALTHCHECK should be in Dockerfile.
If many - last one is used.

Command can be: shell command, exec json array.

Exit statuses of checker:

* 0 - success
* 1 - fail.
* 2 - reserved

```
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```

*Stdout and strderr are stored in the health status and can be
queried with docker inspect*
But only first 4096 bytes.

?? When health status changed, health_status event is generated.
?? What is events ??

===============

# SHELL

RUN, CMD, ENTRYPOINT

`SHELL ["executable", "parameters"]`

Overrides default shell.

Useful for windows, where cmd, powershell and other shells.

Can be used multiple times. Overrides shell for subsequent instructions.

===============

# External implementation features

Only for BuildKit.

* Cache mounts,
* Build secrets,
* Ssh forwarding.

===============

ОДним DOckerfile можно собрать кучку images.
Если там много FROM.
















