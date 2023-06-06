https://www.youtube.com/watch?v=vkdNY8QaCug

#
ElasticSearch (можно OnDemand).


# SaaS (что прям правда мои логи улетают кому-то в облако?)
* Splunk

# Loki

* Можно развернуть через хелм в кубере.
* А можно монолитом.

* Contex - База данных.
* Multi-Tenant - изоляция логов в рамках одной технологии.
* Stream - набор лейблов и значений. Только вперед.
* index + chunks (две базы данных)
Здесь индексируются только labels.

Grafana, grafana-agent (или engine, не расслышал)

# Компоненты

* Distributor
* Ingesters. Чанки в памяти, flush да диск время от времени.
* Storage (s3 like, f.e.)
* Антидубликация данных через хэш от таймстемпа и набора метрик.
* Querers

Loki.LogQL
Похож на promQL
Promtail

Можно разделять что где хранится.

==============

https://www.youtube.com/watch?v=8ZAIwG2ftrE

Сложные вещи в Локи. Как лучше конфигурить.

* Как собрать логи.
* Как извлечь метаданные.
* Как хранить (быстро писать, быстро читать)
* Как быстро искать.

* RSyslog
* Elastic
* GrayLog
* ClickHouse
* GrafanaLoki

===========

https://dev.to/hmake98/centralized-logging-in-microservices-using-grafana-stack-and-fluent-bit-2pji

fluent-bit - log collector. Fetches logs, filters, sends to data store.

loki - stores logs, adding indexes and metadata.

==

# ELK
ElasticSearch stores data with indexes.
Lucene.
Unstructured JSON data in logstash.
Kibana - for visualization.
Обычно занимает много места.

# Loki
Stores key-value pairs, labels, ?metadata?.
Занимает поменьше места.
Но при обильных логах может тратить много времени на обработку.
Много лейблов, много стримов.
Типа лучше выбрать ELK.

У графаны есть свой fluent-bit.

https://yuriktech.com/2020/03/21/Collecting-Docker-Logs-With-Loki/


`docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions`


```yml
logging:
  driver: loki
  options:
    loki-url: "http://host.docker.internal:3100/loki/api/v1/push"

```

```daemon.json
{
    "debug" : true,
    "log-driver": "loki",
    "log-opts": {
        "loki-url": "http://host.docker.internal:3100/loki/api/v1/push"
    }
}
```

Login to your Grafana instance and add a new data source of type Loki.














