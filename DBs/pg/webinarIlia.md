http://www.youtube.com/watch?v=Hf59jSnXYa4

Open Source.

Лицензия похожа на BSD.

?? Посмотреть какие есть книги по PostgreSQL, якобы есть "Несколько толстых книг".

Инструкция по установке:
https://wiki.postgresql.org/wiki/Apt

ЧаВо по установке pgdg.
https://wiki.postgresql.org/wiki/Apt/FAQ

У него демонстрации на Debian.

Добавление в список дистрибов.

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

Debian рулит, т.к. быстро обновляются всякие дистрибутивы.

Имеет смысл собирать pg вручную, с разными оптимизациями, можно выжать процент производительности.

aptitude search postgresql

Несколько минорных релизов, после мажорного - и базу можно юзать.

Контрибы - позволяют пользоваться расширениями ПГ.

ps aux | grep postg

su - postgres

==========

postgres=# \c
You are now connected to database "postgres" as user "postgres".

==========

\d - таблицы

\l - базы
template* базы нужны, не надо удалять.

====



pg_ctlcluster 9.5 main stop -m fast
-m fase - kill 9.

/usr/lib/postgresql/9.5/bin/initdb --help

=======

pg_createcluster 9.5 tiaCluster -E utf-8 --locale=ru_RU.UTF-8 --lc-messages=C


===========

Как поставить локаль в pg_createcluster.
Как посмотреть локали в Debian.

https://wiki.debian.org/PostgreSql

Configuration files: /etc/postgresql/[version]/[cluster]/
Binaries: /usr/lib/postgresql/[version]
Data files: /var/lib/postgresql/[version]/[cluster]

psql - создает воркер.

\h CREATE DATABASE

нельзя создать базу в транзакции.

begin;
rollback;


PG 8к страницы. Отображаются в памяти shared buffers.

Состав страницы:
header  touples tail

Если хоть один тапл изменился вся страничка пометится как грязная.
Перед записью страницы в WAL записывается инфа, необходимая для восстановления этой страницы.

WAL, как я понял, на диске.
Затем WAL синхронизируется с диском.
checkpointer в этом участвует.

коллектор статистики - отдельный процесс.

pg_xlog папка содержит WAL. Может весить много.
Нельзя чистить.

Shared buffers - шарятся между воркерами.

pg_ctlcluster 9.5 tiaCluster stop

Обновить кофиг:
pg_ctlcluster 9.5 tiaCluster reload

Посмотреть для каких конфигов нужно перезагружать базу:
select name, setting, context from pg_settings;


ХОрошо бы юзать pg_bounce
и max_connections сделать таким как в pg_bounce но с запасом
для обслуживания.

ssl - мне не нужно.

Странички подсасываются в кэш ОС, затем в shared buffers PG.
Получается двойное кэширование.

shared_buffers - 
разумно 25% от памяти машины если база больше чем память.
Если меньше - то 75%.
При больших объемах памяти тормозить может дисковое IO.

huge_pages - try для мощного сервера.

work_mem
Память воркера. Обработка зарпосов.

maintenance_workmem - для админских тяжелый сессий - можно
увеличить. Например, построить большие индексы.

pg_tuner фиг знает.

shared_preload_libraries - можно ставить какие-то
анализаторы.

9.4 - update = insert + delete (когда никому не нужна).

Вакуум - очищает свободные места.
Защита от bloat.

autovacuum_analyze_scale_factor
autovacuum_vacuum_scale_factor - агрессивность.
При каком уровне изменений (0 - 1) нужно таблицу отвакуумить.
Может тормозить при медленных дисков.
Имеет смысл даже в 0.01 выставлять.

Если транзакцию открыть, то обязательно закрывать.
Иначе автовакуум не сможет работать с этой таблицей,
и таблица распухнет.

Можно завести какой-то скрипт, который отстегивает долговисящие транзакции.

Неужели нет таймаутов???

large object - очень осторожно, если нет других способов.

wal_level - hot_standby - позвляет делать реплики на лету.

Можно ли настроить отдельное хранилище для WAL ??

fsync - on.

/usr/lib/postgresql/9.5/bin/pg_test_fsync
Скорость.

commit_delay
commit_siblings
Тоже лучше не трогать, нарушаются консистентность.

Чекпоинт. Последнее место, где база обновлялась из WAL.
Если идет восстановление, то можно накатывать из WAL до чекпоинта.

Пакет sysstat.

iostat -x 1 -d

checkpoint_complation_traget = (0-1) Какая часть времени между
чекпоинтами тратится на запись в базу. Если увеличивать - в конце будет интенсивная
запись.
checkpoint_timeout - 
checkpoint_segments (размер буфера)

Походу я не понимаю что такое чекпоинт.
Я не врубаюсь как можно не обновлять базу минутами.











































