https://brianchristner.io/what-is-docker-buildkit/

buildx:

UI ?

https://medium.com/titansoft-engineering/docker-build-cache-sharing-on-multi-hosts-with-buildkit-and-buildx-eb8f7005918e

Платная.

https://docs.docker.com/buildx/working-with-buildx/

Early Access.

Included in docker 19.03.
You can *also* download it.



https://github.com/docker/buildx

Can be used as docker cli plugin.

"experimental": "enabled" can be added to the CLI configuration file ~/.docker/config.json. An alternative is to set the DOCKER_CLI_EXPERIMENTAL=enabled environment variable.

Вроде сказано что bundled но зачемто есть и инсталляция и сборка.

==========

buildx is docker CLI, which extends `docker build` with *buildkit* support.

`docker buildx build`

*does not require DOCKER_BUILDKIT=1*

`--output` - method of outputing of an image.

"docker" driver by default.

Buildx allows to create new instances of isolated builders.
You can create set of remote nodes, forming build farm and quickly switch
between them.

`docker buildx create` - to create new instance.

inspect, stop, rm, ls, use
You can append new nodes to created builder.

`docker context`

drivers:
* docker (local, tarball)
* docker-container

===

* *local* - directory on the client.
* *tar* - single tarball on the client.
* *oci* ?
* *docker*
* *image*
* *registry* - type=image,push=true
* --push - --output=type=registry
* --load - --output=type=ocker
* --cache-from, --cache-to

docker buildx install
To set buildx as default.


https://github.com/docker/cli/blob/master/docs/extend/plugins_graphdriver.md ?

https://github.com/docker/cli/blob/master/experimental/vlan-networks.md

https://github.com/docker/cli/blob/master/experimental/checkpoint-restore.md
Froze containers.

https://testdriven.io/blog/faster-ci-builds-with-docker-cache/

BUILDKIT_INLINE_CACHE

```yml
# _config-examples/single-stage/.gitlab-ci.yml

image: docker:stable
services:
  - docker:dind

variables:
  DOCKER_DRIVER: overlay2
  CACHE_IMAGE: mjhea0/docker-ci-cache
  DOCKER_BUILDKIT: 1

stages:
  - build

docker-build:
  stage: build
  before_script:
    - docker login -u $REGISTRY_USER -p $REGISTRY_PASS
  script:
    - docker build
        --cache-from $CACHE_IMAGE:latest
        --tag $CACHE_IMAGE:latest
        --file ./Dockerfile
        --build-arg BUILDKIT_INLINE_CACHE=1
        "."
  after_script:
    - docker push $CACHE_IMAGE:latest
```

Compose. Cache from.

```yml
# _config-examples/single-stage/compose/.gitlab-ci.yml

image: docker/compose:latest
services:
  - docker:dind

variables:
  DOCKER_DRIVER: overlay2
  CACHE_IMAGE: mjhea0/docker-ci-cache
  DOCKER_BUILDKIT: 1
  COMPOSE_DOCKER_CLI_BUILD: 1

stages:
  - build

docker-build:
  stage: build
  before_script:
    - docker login -u $REGISTRY_USER -p $REGISTRY_PASS
  script:
    - docker-compose build --build-arg BUILDKIT_INLINE_CACHE=1
  after_script:
    - docker push $CACHE_IMAGE:latest
```

Multi stage:

```yml
# _config-examples/multi-stage/.gitlab-ci.yml

image: docker:stable
services:
  - docker:dind


variables:
  DOCKER_DRIVER: overlay2
  CACHE_IMAGE: mjhea0/docker-ci-cache
  DOCKER_BUILDKIT: 1

stages:
  - build

docker-build:
  stage: build
  before_script:
    - docker login -u $REGISTRY_USER -p $REGISTRY_PASS
  script:
    - docker build
        --target base
        --cache-from $CACHE_IMAGE:base
        --tag $CACHE_IMAGE:base
        --file ./Dockerfile.multi
        --build-arg BUILDKIT_INLINE_CACHE=1
        "."
    - docker build
        --cache-from $CACHE_IMAGE:base
        --cache-from $CACHE_IMAGE:stage
        --tag $CACHE_IMAGE:stage
        --file ./Dockerfile.multi
        --build-arg BUILDKIT_INLINE_CACHE=1
        "."
  after_script:
    - docker push $CACHE_IMAGE:stage
```













