# Метрики (prometheus like - SNMP средства, вообще все) Мониторинг состояния железа (SMART дисков, ИБП и т.д.)

## Фичи систем мониторинга и дашборды инцидента

Есть ли информационная панель с 4 мя золотыми сигналами,
или RED ом.

Можно ли посмотреть длительности запросов по процентилям.

### RED
request
* rate
* errors
* duration

### LTES
* latency
* trafic
* errors
* saturation

==========

## Ещё фичи

* Есть ли на этой панели или где-то ещё агрегаторы метрик, где я могу сделать выборку медленных запросов,
и понять где проблема посмотрев метки какой сервис, с какой машины в каком датацентре этот запрос обрабатывал.

* Есть ли на этой панели логи аудита изменений системы (деплои, конфиги, ОС, системные пакеты).

* Есть ли ретро анализ, где видно что произошло ещё в то время как возрасли время запросов.

* Есть ли мониторинг сетевых проблем (например, заломленный сетевой кабель). Есть ли частичная потеря пакетов.
SNMP метрики.

* Хелсчекинг всех сервисов.

* Есть ли мониторинг синхронности часов на всех серверах.

* Есть ли внутренние метрики сервисов, типа /varz:
Что оттуда можно считать?
Можно например рейт сломанных запросов с примерами этих запросов
в заданном процентиле (95м, 99м).
* Есть ли эндпоинты с error rates и latency для каждого типа запроса или RPC.

* Статика и динамика в мониторинге разделена ?

* ?Автоанализ аномалий в запросах пользователей.?

# Метрики методом черного ящика на стороне клиентов

Есть ли системы сбора данных на стороне клиентов.
Например, какой-нибудь ELMAH, с определением какие HTTP запросы
сбоят и отсылкой инфы на сервер наших логов.
Или можно определить, что JS работает долго у юзера.
Может быть мы используем *sentry* для логирования ошибок от фронтов и
бэков.
Может быть что-то типа гуглевского Prober.

На крайняк - залезть на какую-нибудь нашу машину в регионе клиента,
и отуда выполнить запрос.

?Может быть есть какая-то имперсонификация?

# Алертинги

# Логи разных сервисов (Kibana, Loki)

* Есть ли возможность менять уровень вербозности логов на лету?
* Смотрели как это влияет на стабильность работы?

# Средства для трейсинга
Jaeger, Tempo

* Есть ли средства трассировки прохождения запросов через всю систему.

* Есть ли трассировка в хедерах HTTP ответов
X-Request-Trace
куда записан список серверов, обрабатывающих запрос.
коды ответов и времена ответов.

* UID запросов через всю систему.


# Логирование/аудит действий с системой, таких как раскатка новых
версий софта, изменение конфигов, изменение версий OS и системных пакетов, и т.д.
Инфраструктура как код. Гитопс?
Значит можно посмотреть недавние коммиты.

# Средство для ведения инцидента и совместного решения.
Сценарий (плейбук) обработки инцидента с автоматическими и ручными
блоками.

# Автоматизация
Тулзы помогающие при разборе инцидентов.
Как диагностировать так и лечить, может запуск каких-то сценариев диагностики, или само-лечения.