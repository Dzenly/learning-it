https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

Docker image consists of *read only* layers, which contains delta.

* `FROM`
* `COPY`
* `RUN`
* `CMD`

When you run image - new writable layer is created (container layer).

## Create ephemeral containers.
Stateless.

## Build context

CWD

Даже если юзаешь -f Dockerfile, все равно текущая директория потянется
как контекст.

Безопасность в докер контейнерах?

?? Что значит context is sent to docker daemon ?

* Можно не цеплять build context, если посылать Dockerfile через stdin.

* Но если заюзаешь `-f-` то контекст подцепится.

Есть .dockerignore.

## multi-stage build




https://docs.docker.com/develop/develop-images/multistage-build/

17.05+

Cleanup any artifacts you don't need before move to the next layer.


Each from begins new stage.

COPY --from=indexOrName

AS

docker build --target builder -t ...

External image as "stage".

COPY --from nginx:latest

FROM builder as build1 # Existing name of stage.

https://blog.alexellis.io/mutli-stage-docker-builds/

=================================

Only RUN, COPY, ADD create layers.

==================

*Sort multi-line arguments and place them on different lines
(good git diffs)*

# Leverage build cache

docker build --no-cache=true - запретить кэш.

==

* base - search in derived images.
* ADD, COPY - checksum is used for cache miss detection.
last-modified and last-accessed - are not considered.
* Aside from ADD and COPY, other commands use cmd line string match.

Once cache is invalidated, all subsequent comades generate new images.

==========

# FROM

Alpine image is recommended.

# LABEL

Can be useful for easy info access or for automation.

?? On which stage ??

# RUN

Avoid RUN apt-get upgrade and dist-upgrade.
Upgrade could not work from unpriveleged container.
You should contant the image maintainer instead.

But you can upgrade particular package by apt-get install -y foo.

Always combine RUN apt-get update with apt-get install in the same RUN statement ("cache busting"). For example:

RUN apt-get update && apt-get install -y \
    package-bar \
    package-baz \
    package-foo

Otherwise apt-get install will not find new package.

Version pinning.

apt-get clean - automatically runs (after install??) by official debian and ubuntu images.

## Using pipes

/bin/sh -c - смотрит только код последней операции в пайпах.

**RUN set -o pipefail && wget -O - https://some.site | wc -l > /number**

Debian `dash` do not support pipefail. So use exec form and bash.

===============

# CMD

Exec form is recommended.

CMD as params for ENTRYPOINT - requires advanced users.

===============

# EXPOSE

Docker run has flag to map ports, specified by EXPOSE.
Docker provides variables like MYSQL_PORT_3306_TCP
to link containers.

===============

# ENV

 For example, ENV PATH /usr/local/nginx/bin:$PATH ensures that CMD ["nginx"] just works.

 PGDATA, etc.

 It is convenient to set versions by ENV

 ENV PG_VERSION 9.3.4

?? **ENV creates intermediate layer, just like RUN command**

If you need unset variable use RUN VAR=VAL syntax.

# ADD or COPY

ADD - local tar autoextraction.
ADD rootfs.tar.xz /.

COPY files with small portions and in correct order,
to opmimize caches.

```
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt
COPY . /tmp/
```

*Если поменять две последние строки - будет больше проверок кэшей.*


Осторожно с URL.

Плохо:
```
ADD http://example.com/big.tar.xz /usr/src/things/
RUN tar -xJf /usr/src/things/big.tar.xz -C /usr/src/things
RUN make -C /usr/src/things all
```

Хорошо:
```
RUN mkdir -p /usr/src/things \
    && curl -SL http://example.com/big.tar.xz \
    | tar -xJC /usr/src/things \
    && make -C /usr/src/things all
```

Типа лучше когда лучше контроль. Можно удалить архивы, чтобы не захламлять
образ. Или сразу юзать pipe.

Не юзать ADD без нужды.

===============

# ENTRYPOINT

You can use scripts with some arguments handling.

exec inside bash - leads to signals handling.

===============

# VOLUME

to expose, e.g.:

* DB storage area
* configuration storage
* files, created by container

# USER

```Docker
RUN groupadd -r postgres && useradd --no-log-init -r -g postgres postgres.
```

There is bug with big user ID.

don't use sudo, use gosu.

# WORKDIR

Use absolute paths.

Also use absolute paths for cd.

# ONBUILD

Before any command in child Dockerfile (or stage ??)

Images with ONBUILD should set separate tag (containing "onbuild"),
e.g."ruby:1.9-onbuild".

Be careful with ADD or COPY in ONBUILD.



























====

socket работает быстрее, чем tcp.

Использование кэша способно ускорить сборку образов, но тут есть одна проблема. Например, если в Dockerfile обнаруживается инструкция RUN pip install -r requirements.txt, то Docker выполняет поиск такой же инструкции в своём локальном кэше промежуточных образов. При этом содержимое старой и новой версий файла requirements.txt не сравнивается.

```
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
COPY . /tmp/
```

dive














