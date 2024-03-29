https://wiki.postgresql.org/wiki/FAQ

Произносится Post-Gres-Q-L.

object-relational database system.

Проект не контролируется какой-то определенной компанией.

Можно называть Postgres.

Есть лицензия, которую нужно добавлять к своим распространяемым продуктам. Ну и нельзя вешать ответственность на разработчиков Postgres за какой-либо ущерб.

Обычно новый мажорный релиз выходит каждый год.

# Версионность

Мажорные релизы включают новые фичи и выходят примерно раз в год.
9.1 - 9.2 считается мажорным релизом.

Обычно мажорные релизы включают внутренний формат данных. Обратная совместимость со старыми форматами особо не поддерживается.
Обычно для миграции используется pg_upgrade или dump/reload.

Минорные релизы (третье число) используется для баг фиксов.

Хоть и есть риск каких-то глюков при апгрейдах, у комьюнити принцип: более рискованно не апгрейдить.
Апгрейд на минорый релиз не требует редампинга. Просто остановить сервер, обновить, и запустить снова.
Всегда читать релиз ноты перед апгрейдом, т.к. иногда требуются ручные действия.

Мажорные релизы поддерживаются как минимум 5 лет. Затем наступает End Of Life (EOL).
После этого срока могут апгрейдиться только сорцы, для бинарников такой гарантии нет.

Если релиз совсем неудачный, то поддержка заканчивается раньше.

Здесь собраны изввестные баги и планы по развитию:
https://wiki.postgresql.org/wiki/Todo

psql - утилита, в ней есть команды для вывода хелпов по типам, ф-ям и т.д.

========

# Фичи

## Как у крупных коммерческих DBMSs:

* transactions
* subselects
* triggers
* views
* foreign key referential integrity
* sophisticated locking

## Плюс свои:

* User defined types
* inheritance
* rules
* multi-version concurrency control (для уменьшения конкуренции при локах)

# Производительность

+- 10% от коммерческих баз.

# Надежность

Есть куча тестов + минимум месяц бета тестирования перед релизом.
Надежность не хуже, чем в коммерческих базах.

# Поддержка

Скорее лучше чем в других базах. Для желающих есть и коммерческая поддержка.

# Цена

Бесплатно. С очень расслабленной лицензией.

====================


# Клиентские интерфейсы

Ядро включает поддержку только C и Embedded C.
Другие интерфейсы - независимые проекты.
Многие инсталлеры включают инсталляцию и библиотек для разных языков.


===================

# Тулзы

Есть очень много платных и бесплатных тулзов.

https://wiki.postgresql.org/wiki/Community_Guide_to_PostgreSQL_GUI_Tools

==============================

# Заметки для админов

По умолчанию разрешены соединения только с локальной машины с помощью Unix domain sockets иил TCP/IP соединения.

## Настройка производительности

### Модификация запросов

* Создание индексов, включая выражения и частичные индексы.
* Использование COPY вместо нескольких INSERT
* Группировка нескольких стейтментов в одну транзакцию для уменьшения оверхедов при коммитах
* Используй CLUSTER для получения множества строк из индекса (??)
* Используй LIMIT для получения кусочка аутпута запроса
* Используй подготовленные запросы
* Используй ANALYZE для поддержки точной статистики оптимизатора (??)
* Регулярно используй VACUUM или pg_autovacuum.
* Dropping of indexes during large data changes (??)

### postgresql.conf
Administration Guide/Server Run-time Environment/Run-time Configuration.

### hardware
В основном IO система и ОЗУ. В меньшей степени - CPU.

====================

Запускает процесс на каждую сессию работы с базой (соединение).
Postgres может иметь ещё дофигища всяких вспомогательных процессов.

Из-за непонимания утилитами shared memory они показывают завышенное потребление памяти.
Также бывают неверные сообщения о мемликах в shared memory.

================






























