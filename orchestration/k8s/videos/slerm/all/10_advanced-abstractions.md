https://www.youtube.com/watch?v=HpUmJCyOrD0&list=PL8D2P0ruohOA4Y9LQoTttfSgsRwUGWpu6&index=12&t=312s

Куб для мониторинга может предложить:
* Static PODs
Запускается не в etcd, а на узле в конфигах кублета.

* Pod Anti Affinity
Не поднимается автоматом, если вводится новый узел.

* Daemon Set
Автоматом добавляется на узел, при введение узла в строй.
Кол-во реплик не указывается, т.к. равно кол-ву узлов.

```yml
nodeSelector:
  beta.kubernetes.io.os: linux
...
tolerations:
  - effect: NoSchedule
  key: node-role.kubernetes.io.master
```
taint - зараза.
vs
tolerations

========

# StatefulSet

Если запускаешь несколько деплойментов - они запускаются
рандомно.

Каждому поду присваивается уникальное имя с порядковым индексом.

По умолчанию StatefulSet запускает поды последовательно.
Дожидается readiness probe == true.

При удалении не удаляет PVC.

Если ты сделал три Deployment, и сделал им PVC,
они все ссылаются на выданный PV.

Persistent *volumeClaimTemplates*.
Соответственно у каждого под свой уникальный PVC, связанный
со своим уникальным PV.

Используется для всяких Rabbit, DBs, Redis, Kafka, etc.

Не рекомендуется для прода с большой нагрузкой.

А вот для разработки, тестов и стейджинга - норм.

RabbitMQ - интегрировались с кубером.
И норм с ним работает.

sts - сокращение

Есть POD affinity, есть Node Affinity.

nodeSelector - только одно значение для метки.

nodeAffinity - несколько значений для метки.

requiredDuringSchedulingIgnoredDuringExecution
preferedDuringSchedulingIgnoredDuringExecution

Обычно нет смысла запускать на одном ноде два пода для STS.
```yml
affinity:
  podAntiAffinity:
    ...
```

Если нужен кэш, то лучше его запихать в тот же под,
чем на тот же нод отдельным подом.

=========

# initContainers
* Какие-то настройки.
* Выполняются по порядку описания в манифесте
* Можно монтировать те же тома, что и в основных контейнерах
* Можно запускать от другого пользователя.
* Должен выполнить действие и остановиться.

===========

# Headless Service

.spec.clusterIP: None

Не создается IP tables правил на узлах.

А создаются DNS записи.

Так сервисы знают имена других реплик.

nslookup rabbitmq - все адреса.
nslookup rabbitmq-0 - конкретный адрес.


















