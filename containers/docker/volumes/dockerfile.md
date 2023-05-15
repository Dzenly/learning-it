?? Is there difference in place where VOLUME is in Dockerfile.

?? Changing the volume from within the Dockerfile: If any build steps change the data within the volume after it has been declared, those changes will be discarded.

WTF


https://docs.docker.com/engine/reference/builder/#volume

Creates mount point with the specified name.
So it will use some external volumes.

JSON array or just string with multiple args.

`docker run` inits newly created volume with data from base image.

Windows based containers: volume must be non-existing or empty dir or drive other then C:

**some bullshit**
Changing the volume from within the Dockerfile: If any build steps change the data within the volume after it has been declared, those changes will be discarded.

list is parsed json array

VOLUME /var/log /var/db
or
VOLUME [ "/var/log", "/var/db" ]

You can't mount host dir from within some Dockerfile.
