https://docs.docker.com/storage/bind-mounts/#configure-bind-propagation

Default rprivate.

only for bind mounts on linux hosts.

given mount point or replicas.

mounted
/mnt -> /tmp

will mount /tmp/a be accessible as /mnt/a
/tmp/a -> /mnt/a


Consider that /tmp/a is also mounted as /foo.


shared - both directions
slave - replica sees original sub-mounts but not vise versa.
private/rprivate - no propagations
rshared - (? r - recursive) - same as shared, plus nested mount points
rslave - slave + recursive.

