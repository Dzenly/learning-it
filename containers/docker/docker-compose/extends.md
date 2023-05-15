https://docs.docker.com/compose/extends/

Sharing common cfgs.

# Multiple compose files

By default Compose reads 2 files:
* docker-compose.yml (base cfgs) and optional
* docker-compose.override.yml (overrides).

If a service defined in both files: Compose merges cfgs as described in
https://docs.docker.com/compose/extends/#adding-and-overriding-configuration

-f  можно задавать список файлов, они все смержатся в порядке,
указанном в cmd line. При этом будут мержиться только указанные файлы.

Relative to base compose file.

Override files need not to be valid docker-compose.yml.
It can contain just fragments.

==========

# Admin tasks

==========

https://docs.docker.com/compose/extends/#adding-and-overriding-configuration

Entries for volumes and devices are merged using the mount path in the container:






