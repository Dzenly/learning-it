https://www.youtube.com/watch?v=HzD228hMdwY

Проблема посылать трафик в контейнер??

Bridge - сетевой свитч на уровне операционки.
Два виртуальных интерфейса, один в контейнере, другой в бридже.

ip link set veth1 netns ns1

network namespase isolates network.

Собственный TCP/IP стек с таблицами маршрутизации.

macvlan
вместо доп. интерфейса - доп. мак адрес на основном интерфейсе.

pipework

overlay

weave

 libnetwork

 


