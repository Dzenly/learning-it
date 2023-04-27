https://www.youtube.com/watch?v=jUbOm0B-eKQ

Senior - уже System Design.

Требования: функциональные, нефункциональные.

* Maintainability
* Low Latency
* i18n
* High Throughtput
* High Availability
* Information Security
* Auditability
* Usability

Потоки данных.
Компоненты системы.
Corner cases, когда части системы отваливаются.

Публичные API
Компоненты.
k/v
rdbms, column family
Модели данных для обмена.
Что Persistent,
Что in memory.

=========

Выбор технологий
Расчет мощностей под нагрузку

============

# Что надо уметь на Sys Design Interview

* Задавать правильные вопросы, уточнять что входит в скоп задач, а что нет. Например, какие части системы уже есть?
* Собирать функциональные требования в виде желаемых сценариев системы.
Что хочет юзер.
* Уточнить приоритеты нефункциональных требований.

# Что стоит изучить для функциональных требований
* Use cases from UML
* Corner cases
* Happy Path
* User story
* Jobs to be Done

# Для нефункциональных
* https://en.wikipedia.org/wiki/Architecture_tradeoff_analysis_method
* Software Requirements. Third Edition.
* Software Architecture for Busy Developers

# Что уметь

* Выбирать правильный способ интеграции нашей системы с другими системами
Files, DBs, API, Messaging.

* Правильный подход к API: REST, RPC, GraphQL, AsyncAPI...
* Описать контракты в выбранном подходе.
* https://c4model.com/
* Сети и протоколы.
* DNS, DHCP


* Описать поток работы (happy path)
* Exceptional flows и как их обработаем (важно понять насколько глубоко копать, особенно на интервью)
* read/write path
* c4model: container Diagram
* Sequence Activiy Diagrams from UML
* IDEFO и DFD диаграммы
* BPMN

Концептуальная схема

* stateful/stateless
* Связывать между собой компоненты
* Классы для stateful компонентов.
RDBMS, NoSQL, k/v, Documents, Column-oriented, Graphs.

DDD: Submomains, Bounded Context.
12 факторное приложение.

ER-Diagramms. Class Diagramms.
12 - Factor APPs.

БД и границы применимости.
Как работают оркестраторы k8s.

Концепция failure domains

logs, monitoring, migrations.

HPA, VPA

======

Интервью
* Помнить о времени.
* Проектировать не сразу, а уточнить все сначала.
* Интерактивность.
* Проявлять самостоятельность и инициативу.
* Реагировать на наводящие вопросы и уточнения.
* Какие-то вопросы от себя в конце интервью.

https://www.youtube.com/watch?v=Wh5Ya6UFG1k&ab_channel=%D0%9A%D0%BE%D0%BD%D1%84%D0%B5%D1%80%D0%B5%D0%BD%D1%86%D0%B8%D1%8FArchDays

Кэширование.

Монго выше скорость репликации, чем в PG ?

Шардирование.

Если вводишь свою платежную систему, должен выполнять требования.
Очередь.

Доменная модель.

Могут увеличивать цену по мере заканчивания мест.

Риски овербукинга для разных типов номеров.

CockroachDB - поддерживает распределенные транзакции.

Yandex DB ?

Часть на клиенте - идентификаторы.
UUID v 4.

Не делать больше чем надо.
Спрашивать что уже готово.

Картинки - географически распределенный CDN.
И мож другая статика.

Нестабильный инет - важно учитывать.

Уровни изоляции. Где можно потерять данные и обработать на уровне приложения ?

Какие румтайпс свободны.

`select from room_types where hotel_id, room_type_id, betweed dates (start, end)`
update start_date, end_date
booked_cnt
Много row меняется в room_types.

Если бронирую на три дня. В room_types будет три записи.
Т.е. по записи на каждую дату.

room_type.count - сколько таких комнат.

LocalStorage.

Sequence Diagrams.
Activity Diagrams.
































