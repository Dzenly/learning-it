https://docs.docker.com/storage/storagedriver/overlayfs-driver/#how-the-overlay2-driver-works

OFS наслаивает two dirs on linux host and presents them as a single dir.
These dirs are called *layers*.

Their unification is *union mount*.

lowerdir/upperdir/merged.

OFS2 supports 128 lower layers.

https://habr.com/ru/post/462849/


docker build / commit

/var/lib/docker/overlay2/l

diff
link
lower
merged
work

https://docs.docker.com/storage/storagedriver/overlayfs-driver/#how-container-reads-and-writes-work-with-overlay-or-overlay2


Если перезаписываешь огромные файлы - будет мощный оверхед по перформансу.

?? Но как идет работа с волюмами ?

Интересная фича для ренейминга директорий.









