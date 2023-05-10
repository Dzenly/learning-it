https://www.youtube.com/watch?v=0rN_tUIZx7Y&list=PL8D2P0ruohOBSA_CDqJLflJ8FLJNe26K-&index=7&ab_channel=%D0%A1%D0%BB%D1%91%D1%80%D0%BC

# Etcd

RAFT

3 or 5 nodes.

# API server

Центральный компонент.
REST API
* Единственный кто общается с etcd

stateless
3 node master - на всех API Server + Etcd.

Authentication, authorization.

# Controller-manager

Набор контроллеров.
Бинарь.
Реализует абстракции.
* Node Controller (отслеживает инфу о доступных нодах)
* ReplicaSetController
* Endpoints controller (for services, e.g.)

GarbageCollector - удаляет ненужные объекты.

Подписан на разные события в API Server.

# Sheduler

Назначение объекто на ноды.
QoS
Affinity/anti-affinity
Requested resources
Priority Class

Обычно по одному на каждой мастер ноде.

# Kubelet

* Работает на всех нодах (и на воркерах, и на мастеровых).
* Единственный компонент, который работает не в контейнере.
* Отдает команды допустим докер демону.
* Создает поды.
* Передает инфу в API Server.

# Kube-proxy

* Стоит на всех нодах.
* Управляет сетевыми правилами.
* Смотрит в API.



====

Доп компоненты:
* Контейнеризация.
* Сеть.
* DNS


Хорошо бы Etcd бакапить.

Чтобы добавить нод - добавляешь кублет и настраиваешь.

Кублет очищает образы сам.

БД в кубере - сложно, но можно.



