https://docs.docker.com/compose/

Обычно, чтобы одной командой запускать *много* контейнеров.

* Можно юзать, чтобы иметь несколько фиче бранчей одного проекта на одной машине.
* При CI для сепарации билдов.

docker-compose up - запуск одного или более контейнеров.
Похоже с зависимостями.

Упрощает документацию старта продукта (видимо, т.к. зависимости
разруливаются сами)

=======

# 3 steps

* Define your app ?environment? in *Dockerfile*.
* Define services of your app in *docker-compose.yml*.
* docker-compose up

services, volumes.

============

Managing lifecycle of your app:

* Start, stop, rebuild services
* View the status of running services.
* Stream logs from running services.
* ?? Run one-off command on a service ??

==========

# features

## Multiple isolated envs on a single host.

Project name to isolate envs.

To keep builds from interfering each other, use unique build id
as suffix for project name.

Default prj name is directory basename.

`-p` cmd line option defines project name (COMPOSE_PROJECT_NAME).

# Preserve volume data when containers are created.

Compose preserves volumes.
*Copyies volumes from ol contaienr to new one.*
Keeps volumes from prev runs and use them at current run.

# *Only recreate containers that have changed*



Reusing existing if configuration cache hit.

# Variables and moving a composition between envs ??

Variable substitution.
Extend.

========================

# Common use cases

* docker-compose.yml can be used as a documentation for services relationship.

* Testing environment when there are many dependencies.



==============================











