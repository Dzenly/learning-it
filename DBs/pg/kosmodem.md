https://www.youtube.com/watch?v=jGOkSerUPw4

?? Двухфазное блокирование.

?? Двухфазный коммит.

При компиляции можно изменить размер страниц.
mmap.

Кэш ПГ - Модифицирумый LRU (странички имеют веса).

Чтобы не ждать записи на диск до коммита транзации придуман
WAL.



===============
ProcArray - в шареной памяти. Создается для каждого воркера.
Служебная инфа (бд, PID воркера, локи, ...)
Как минимум по 2 легковесных лока на страницу.


Лок менеджер - тяжелые блокировки.
pg_locks
Deadlock detector.
Гранулярность высокая, можно менять много таплов одновременными
транзакциями.



WAL buffers.
По умолчанию 7 кб, но на производительной системе имеет
смысл делать 16МБ.

Весь буфер дампится в WAL при коммите или когда заполнится.

oDirect - пока не подружили.

x - все, что связано с транзакциями.
WAL - xlog. Удалять нельзя.

Чек поинт.

Асинхронные чекпоинты.

В Oracle WAL называется Redo логи.
undo (старые таплы) - живет прямо в страницах.

WAL файл - 16 мб - задается при компиляции.

=========

Checkpoint spikes - если WAL пишется слишком быстро.


pg_stat bgwriter.
Статистика.
Посмотреть график.

Похоже рейд контроллер с батарейкой имеет большой и быстрый кэш.

====

barrier = 0, noatime, BBU.


PG ещё не дошел до жизни без ОС.

Насктроить в ОС vm.dirty_ratio vm_dirty_background_ratio -
так чтобы они соответствовали кэшу дисков.

Ибо если писать на диск что-то больше кэша - кэш бесполезен.

Лучше поставить background - 64 мега (даже на крутых серверах)
и dirty - 512МБ.

wal_buffers 768kB -> 16Mb.
checkpoint_segments
checkpoint_timeout
checkpoint_completiontraget = 0.9

vacuum - удаляет старые таплы.


autovacuum_vacuum_scale_factor 0.01

Что за тост хранилище??

Автовакуум.
Агрессивно в ПГ, и притушить найсом со стороны ОС.

Кл-во воркеров.

ik@postgresql-consulting.com

Есть режим репликации, когда коммит не приходит, пока
изменения не применились на слейве.


fillfactor - 0.7

На винде ПГ сильно хуже.

Якобы в ПГ нет дебагера.

explain analyze позволяет оценить workmem.




===============
