https://www.youtube.com/watch?v=8Wk1iI8mMrw&list=PL8D2P0ruohOBSA_CDqJLflJ8FLJNe26K-&index=5&ab_channel=%D0%A1%D0%BB%D1%91%D1%80%D0%BC

# HostPath
Монтирование.

Лучше запретить политиками безопасности.

```yml
volumes:
  - name: some-volume
    HostPath: /some_path
```

# EmptyDir
Временный диск.
При рестарте контейнера - оставляются данные.
Но если под удаляется - то и этот волюм тоже.

Фигурные скобки - пустой словарь.

`/var/lib/kubelet`

# PersistentVolumeClaim

claimName

Размер, система хранения, тип доступа, SWMR

StorageClass -

PVC - заявка.
*PV - конкретный волюм, выданный приложению.*

StorageClass (e.g. NFS)

Допустим, есть пул PV.
Заказанный волюм переходит в режим bound.

======

Ceph -
https://habr.com/ru/articles/313644/
Open Source storage solution for
block, file and object storage.

Под капотом может юзать XFS

======

# PV provisioners

Автоматом создает диски под PVC.

Может быть дефолтьный Storage Class.

======

Теоретически можно закидывать файлы
в конфиги, которые подмаплены как директории.

В deployment может быть
spec/initContainers

`k get pv`

`-o wide` - больше подробностей

Можно легко расширить размер PVC просто изменением
манифеста.

Но расширение м.б. только при пересоздании пода.

Уменьшить размер диска нельзя.

====

initContainers
Можно менять права на файлы.
По умолчанию владелец root (uid = 0).

Может накатывать пресет БД.

Может быть несколько.

initContainers должны остановиться.

CSI - Container Storage Interface

emptyDir по дефолту создается на диске,
но можно подкрутить чтобы в памяти.

 























