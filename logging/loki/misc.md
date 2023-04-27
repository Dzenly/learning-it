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







