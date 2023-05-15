https://docs.docker.com/glossary/

# base image - no parents.

# boot2docker - lightweight linux distribution (deprecated).

# Docker ee - есть облако, есть on-premise.

# Docker hub - умеет автобилдить, видимо по репам от Github/Bitbucket.

# ENTRYPOINT - Позволяет задавать параметры запуска, как и CMD.

Can be inherited from base image by FROM keyword.
--entrypoint overrides.

CMD - arbitrary string, allows to add multiple commands and flags.
Overriden by docker run cmd line (everything after container name).

# libcontainer - Go tool, extenging docker abilities.

# link - deprecated way to link container with another one.

# namespace - Linux way of processes isolation.

# persistent storage - do not destroy after container destroying.

# repository

docker search - ищет репу.

# tag

#



==========

Union mount -


UFS
Union File System
* Base Layer (RO) (?? base docker image ??)
----
* Overlay Layer (??Main user view ??).
When you change files in this layer - changes are stored in diff layer.
(?? current state of docker container (oversimplifying))
----
* Diff layer

Currently existing files from base layer are COW.
----

Docker images are UFS stacked on top of each other.

==========

Volume

* directory within one or more containers.
That bypasses union File System.

==============

* host volume - lives on Docker host's fs, can be accessed from container.
* named volume - ?? Создает сам docker ?
* anonymous volume ?? создает сам docker, но хрен знает где.



