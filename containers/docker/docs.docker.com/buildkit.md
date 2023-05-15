https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md

export DOCKER_BUILDKIT=1

docker build

# syntax=docker/dockerfile:experimental

https://docs.docker.com/engine/reference/builder/#syntax
# syntax=docker/dockerfile:1.1.3-experimental

# RUN --mount=type=bind (default)

## Options

* target (required)
* source (src path in the from, defaults to root of the from)
* from (Build stage or image name for the src root, defaults to BC)
* rw, readwrite (Allow writes on the mount. *Written data will be discarded*)


# RUN --mount=type=cache

Allows to cache directories for compilers and package managers.

* id - Optional id to separate caches.
* target (required) - mount path
* ro, readonly
* sharing: shared (multiple writers concurrently, private - COW, locked - like mutex)
* from - Build stage as base of the cache mount. Defaults to empty dir.
* source - subpath in the from. Defaults to root of the from.
* mode - file mode for new cache directory.
* uid - user ID. Defaults to 0.
* gid -

```
# syntax = docker/dockerfile:experimental
FROM golang
...
RUN --mount=type=cache,target=/root/.cache/go-build go build ...
```

# RUN --mount=type=tmpfs

* target (required) - mount path.

=====

# RUN --mount=type=secret

* id - ID of secret, defaults to basename of the target path.
* target - Mount path. Defaults to /run/secrets/ + id
* required
* mode / uid / gid

```
# Example: access to S3
# syntax = docker/dockerfile:experimental
FROM python:3
RUN pip install awscli
RUN --mount=type=secret,id=aws,target=/root/.aws/credentials aws s3 cp s3://... ...
$ buildctl build --frontend=dockerfile.v0 --local context=. --local dockerfile=. \
  --secret id=aws,src=$HOME/.aws/credentials
```

# RUN --mount=type=ssh

* id
* target - ssh agent socket path
* required
* mode / uid / gid


# RUN --security=insecure|sandbox

# RUN --network=none|host|default

Per instruction net access management.
Например, когда у команды есть побочные эффекты от лазания в инет,
- можно обрубить инет для неё.

=====









