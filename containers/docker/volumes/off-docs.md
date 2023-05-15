https://docs.docker.com/storage/

By default all files created inside a container are stored on a writable layer.

*Volumes* and *Bind mounts*

Linux only: tmpfs mount.

Windows only: named pipe.

The data looks the same from the container, no matter which type of mount you choose.

Directory or file.

# Volumes:
 /var/lib/docker/volumes
Non docker processes should not modify this dir.

# Bind mounts.
Everywhere on host system (even system files).
Non docker processes can modify them.

# tmpfs
Host OS memory.

========

docker volume create.

One volume can be mounted to multiple containers simultaneously.

==========

# Named and Anonymous Volumes

The same management. Only name differs.

=======

# Volume drivers
Remote hosts or Cloud providers.
(not for bind mounts)

============

# Bind mounts

The file or dir are referenced by its full path on the host.
It is created on demand if do not exist.

Use them on if needed.



===================

# Tmpfs

Also used by swarm to keep secrets.


==========

--mount flag is more clear.

==============

# Good cases for volumes

Sharing data between multiple containers.
And backup.
Copying stand.
Docker Desktop. Linux VM (Mac, Win).
Too slow bind mounts and where flush should be accessible (DB e.g.).

========

# Good cases for bind mounts

Sharing config from host to containers.
Docker profives DNS by mounting /etc/resolv.conf.

**Developer environment. Sharing source code.**


# Tmpfs mounts.

Secure data.

====================

# Tips

Empty volume filled from container.
Non existing volume is created and filled.

*Bind mount* or *Non empty volume* - obscures existing files and dirs in container.

=============================

https://docs.docker.com/storage/volumes/

Some container can pre-populate the volume.

Volumes are better choice then writable docker layer.

Cause containers can be ephemeral.

Non persistent - tmpfs mount.

rprivate bind propagation.

==========

-v, --volumes - 3 fields separated by colon.

--mount - order of keys is not significant.

* *type* - bind, volume, tmpfs.
* *source*
* *destination/dst/target*
* *readonly*
* *volume-opt*


```
docker service create \
    --mount 'type=volume,src=<VOLUME-NAME>,dst=<CONTAINER-PATH>,volume-driver=local,\
    volume-opt=type=nfs,volume-opt=device=<nfs-server>:<nfs-path>,"volume-opt=o=addr=<nfs-address>,vers=4,soft,timeo=180,bg,tcp,rw"'
    --name myservice \
    <IMAGE>
```

Volumes can be created. Bind mounts - not.

==========

docker run creates non existing volume.

==================

https://docs.docker.com/storage/volumes/#share-data-among-machines

Like amazon S3 or NFS.


docker has plugins.

We can use NFS for artifacts.zip delivery.

https://docs.docker.com/storage/bind-mounts/


-v, --mount diferences.
--mount generates error of directory or file absent on host.


https://docs.docker.com/compose/compose-file/compose-file-v3/#volumes


named volume across multiple services.
top-level *volumes* key.





```
volumes:
  # Just specify a path and let the Engine create a volume
  - /var/lib/mysql

  # Specify an absolute path mapping
  - /opt/data:/var/lib/mysql

  # Path on the host, relative to the Compose file
  - ./cache:/tmp/cache

  # User-relative path
  - ~/configs:/etc/configs/:ro

  # Named volume
  - datavolume:/var/lib/mysql
```

tmpfs -> size.

























