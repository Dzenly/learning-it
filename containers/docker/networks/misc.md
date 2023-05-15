bridge позволяет лазить вне хоста.

Он всего лишь изолирует от других контейнеров, которые вне бриджа.

bridge будем делать только для того же хоста.

Другие коллекторы должны будут светить свои порты.

======

В дефолтном бридже контейнерам даются IPшники, и они могут
с друг другом коммуницировать по IP.

Если слинкуешь, типа не нужно экспозить порты.

линк меняет /etc/hosts

И ещё создает кучу переменных окружения, типа:

DB_NAME=/web2/db
DB_PORT=tcp://172.17.0.5:5432
DB_PORT_5432_TCP=tcp://172.17.0.5:5432
DB_PORT_5432_TCP_PROTO=tcp
DB_PORT_5432_TCP_PORT=5432
DB_PORT_5432_TCP_ADDR=172.17.0.5

В общем, как я понял, порты экспозить не надо.
Контейнеры внутри бриджа их увидят.

В дефолтной сети нужно юзать --link.
Иначе контейнеры не будут знать друг друга.

В дефолтной сети контейнеры видят друг друга по IP.

By default, traffic from containers connected to the default bridge network is not forwarded to the outside world.

sysctl net.ipv4.conf.all.forwarding=1
iptables -P FORWARD ACCEPT

https://docs.docker.com/network/host/

Linux only.

Контейнеры слушают порты прямо с хоста.
Типа это может быть получше по производительности.
И ещё иногда контейнеры нужно слушать дофига портов, и запаришься
их мапить.


https://docs.docker.com/engine/reference/commandline/network_create/

Создать можно либо bridge либо overlay.

Нельзя удалить дефолтный bridge network (docker0).

Оверлеям нужно какое-то key-value store.
* cluster of hosts with connection to this key-value store.
* daemon config on each host of the cluster.







