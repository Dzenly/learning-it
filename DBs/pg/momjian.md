http://www.youtube.com/watch?v=JFh22atXTRQ

libpq  - C library.

pq - post quel (competitor of SQL).

Многие скриптовые языки юзают libpq.
Из-за этого документация по libpq сильно похожа
на доки в этих языках.

JDBC - юзает что-то свое.

libpq не 1 к 1 передает данные ПГ, но близко.
Там, видимо идет заголовок и запрос.

А может быть libpq позволяет преобразовывать какие-то
пг данные в сишные структуры??


ЗАпрос превращается в parsing tree.

Postmaster слушает 5432 и создает postgres.
С этим process и общается приложение.

Локальные для процесса хрени (наверное, типа сортировки)
идут в приватной памяти процесса.
Но есть и shared memory.

Нельзя убивать postgres.
postmaster подумает, что shared memory в неконсистентном
состоянии, и перезапустит все с нуля (как я понял).

Если надо остановить - юзает специальные команды.
Там через глобальные переменные процесс безопасно остановится.

Процессы общаются через shared memory, semaphores,
network connection.

Парсинг запросов это довольно тяжелый процесс и
делать его в потоках накладно.

Да и тогда любой поток может завалить весь процесс.

Трудно все синхронизировать.
Много ошибок (на опыте информикс 6, 7)

Ничего страшного в процессе нет.
Можно создавать пулы.
pg_bouncer.



Прежде чем удалить или обновить нужно селектнуть.


Обработка запросов сильно одинаковая в любых крутых БД.

===

Он говорит, что если писать на диск при каждой транзакии,
диску копец.

WAL должен быть на очень надежном носителе.

WAL хранится в очень эффективном бинарном формате.

Похоже, корректные шатдауны запиысываются в WAL
и при старте ПГ проверяет их, если нет - был крэш.


















