https://habr.com/ru/post/477464/

Просто пробросить сокет докер демона?

Dind часто ломается при выходе новых докеров.

DinD - как кэшировать образа?

Overlay on Overlay - slow.

http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/


Device Mapper is not namespaced.
If multiple instances Docker use on the same machine, they able to see
each other's image and backing devices.

So, use /var/lib/docker volume.

But Docker daemon designed to have exclusive access to /var/lib/docker.

For complex containers "watch the world burn".

Just expose Docker socket to your CI container,
but bind-mount with -v.

docker run -v /var/run/docker.sock:/var/run/docker.sock ...

So container will be able to start sibling containers.

https://habr.com/ru/company/ua-hosting/blog/488536/



