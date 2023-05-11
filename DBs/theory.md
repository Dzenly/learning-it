В русских статьях, включая википедию, большинство авторов не понимает тему.
Да и в зарубежнных статьях тоже люди пишут дезинформацию.

Лучше смотреть тут:

https://en.wikipedia.org/wiki/Isolation_%28database_systems%29#Non-repeatable_reads

https://stackoverflow.com/questions/11043712/what-is-the-difference-between-non-repeatable-read-and-phantom-read#:~:text=Non%2Drepeatable%20reads%20are%20when,or%20DELETES%20from%20another%20transaction.

# Уровни изоляции транзакций

## Возможные проблемы параллельного доступа с использованием транзакций

### Write skew

Два разных писателя, которые перед этим прочитали столбцы.
В результате микс. Пока не понял чем это отличается от Lost Update.

### Потерянное обновление (Lost Update)

При одновременном изменении одного блока данных несколькими транзакциями
теряются все изменения, кроме последнего.

Пример:

```SQL
UPDATE tbl1 SET f2=f2+20 WHERE f1=1;
UPDATE tbl1 SET f2=f2+25 WHERE f1=1;
```
В результате какая-то из этих транзакций пропадет.

### Грязное чтение (Dirty Read)

Транзакция меняет или добавляет данные.
Ты читаешь.
А транзакция потом откатывается.
Соответственно то, что ты прочитал - неактуально.

Транзакция 1
```sql
UPDATE tbl1 SET f2=f2+1 WHERE f1=1;
ROLLBACK WORK;
```

Транзакция 2
```sql
SELECT f2 FROM tbl1 WHERE f1=1;
```

### Неповторяющееся (невоспроизводимое?) чтение (Non-repeatable Read)

Как я понял речь идет про чтение одной строки.
При повторном чтении в рамках одной транзакции ранее прочитанные данные оказываются измененными.

Транзакция 1
```sql
SELECT f2 FROM tbl1 WHERE f1=1;
SELECT f2 FROM tbl1 WHERE f1=1;
```
Транзакция 2
```sql
UPDATE tbl1 SET f2=f2+3 WHERE f1=1;
COMMIT;
```

Особенно плохо, когда данные читаются для того, чтобы их поменять.

### Фантомное чтение (Phantom Reads)

Первая транзакция несколько раз выбирает множество строк по одним и
тем же критериям.
Вторая - добавляет строки или меняет столбцы некоторых строк, подходящих
под критерии первой и успешно заканчивается.
В результате одни и те же выборки первой - дают разные строки.

Как я понял:
Отличается от non-repeatable read тем, что тут речь о нескольких строках.
И тем, что тут до и после данные в таблице могут быть одинаковы.
Но результат какой-нибудь операции над всеми строками (сумма столбца например), может быть разным. Т.к. на секунду были другие значения.
Вот они и называются фантомами, т.к. их больше нет.

================================

# Concurrency control

https://en.wikipedia.org/wiki/Concurrency_control

================================

# Records locking

https://en.wikipedia.org/wiki/Record_locking
https://stackoverflow.com/questions/12179130/what-are-range-locks

================================

https://en.wikipedia.org/wiki/Isolation_%28database_systems%29#Non-repeatable_reads

# Isolation levels

## Read Uncommitted (PG такое не умеет).
Транзакции видят незафиксированные изменения других транзакций.
Читаешь как есть. Без блокировок.
Возможны все проблемы:
* Dirty Read - Каждая транзакция видит незафиксированные изменения другой транзакции.
* Non-repeatable Read
* Phantom Read.

## Read Committed
Lock-based concurrency control.
Write is always locked.
Read is locked until the write finish.
Читаешь только если предыдущая транзакция прошла.
*non-repeatable read* can occur.

## Repeatable read. Snapshot Isolation

read and write locks on selected data.
no range-locks.
*phantom reads* can occur.

## Serializable
read and write locks on selected data.
range-locks for SELECT ranged where clause.

https://stackoverflow.com/questions/12179130/what-are-range-locks
https://retool.com/blog/isolation-levels-and-locking-in-relational-databases/#:~:text=Range%20locks%20are%20a%20mechanism,rows%20(before%20and%20after)

range-lock механизм лоченья строк, который в твоем запросе.
?И близко к нему?
По 1й вроде.
Если таких близких строк нет - лочится все до этой границы (0 или конец).


Snapshot isolation as implementation.
https://en.wikipedia.org/wiki/Snapshot_isolation
Snapshot isolation - гарантия, что
все чтения идущие в транзакции, видят консистентный снапшот БД.
На практике это момент перед стартом транзакции.
И транзакция может успешно закоммититься только если
нет параллельных апдейтов с конфликтами.
Все основные БД поддерживают.
PG, MSSQL, Oracle, MySQL, MongoDB.

Обычно через
https://en.wikipedia.org/wiki/Multiversion_concurrency_control
Это не так надежно как
https://en.wikipedia.org/wiki/Serializability
но на практике норм.

================================

# CAP
https://en.wikipedia.org/wiki/CAP_theorem

Применяется скорее не к БД а к БД + бизнес-логика.

Каждая распределенная система может соблюдат только два из трех условий.

## Consistency

Every read receives the most recent write (or error).

## Availability

Every request receives a (non-error) response, без гарантий, что данные свежие.
Я так понимаю Availability касается также и данных.

## Partition tolerance

Система остается рабочей не смотря на неограниченное кол-во сообщений
теряемых или задерживаемых сетью.

При сбоях в сети приходится выбирать:
* Либо завершить операцию, и уменьшить Availability.
* Либо продолжить операцию, но получить риск Inconsistency.

====

ACID-DBs выбирают Consistency over Availability.

BASE-DBs (например NoSQL направления) выбирают Availability over Consistency.

Block-chain - AP. And Eventual Consistency.

## PG

Репликация Master->Slave.
Двухфазные коммиты.

## MongoDB

Один мастер.
Сбой в сети - прекращение приема записей.

=====

Проблемы CAP теоремы.

Если систем отвечает час - считается ли она доступной?
Что если доступна половина системы?

================================

https://habr.com/ru/companies/simbirsoft/articles/572540/


https://en.wikipedia.org/wiki/PACELC_theorem

In Partitioned, one has to choose between A and C.
But Else
In Partition absense - choose between Latency or Consistency.

===========

# Примеры БД для разных PACELC

Fully ACID DBs - PC/EC, они не пожертвуют Consistency.

MongoDB - PA/EC -

Колоночные базы - наверное PA/EL  - Кассандра. КликХаус.

================================

# ACID

Свойства транзакции в БД.

https://en.wikipedia.org/wiki/ACID

## Atomicity

Each transaction is treated as a single unit, which either succeeds completely or failed completely (and DB left unchanged).
Никаких частичных изменений.
Крэши, выключения питания - все учитываем.

## Consistency

Transactions brings DB from one consistent state to another.
Constraints, Cascades, Triggers, Foreign Keys.

## Isolation

В PG прям можно выбирать изоляции.
https://tapoueh.org/blog/2018/07/postgresql-concurrency-isolation-and-locking/

Двухфазный локинг
https://en.wikipedia.org/wiki/Two-phase_locking
1. Expand phase: получаем локи, и не отпускаем.
2. Shrinking phase: отпускаем локи и не получаем.
Есть Shared и Exclusive locks.

Могут быть дедлоки.

## Durability

Дублирую то же самое, что и для Atomicity.
Типа сохраняемость данные при power failures.

================================

# BASE

https://en.wikipedia.org/wiki/Eventual_consistency

Eventually consistency.
Рано или поздно в базе ты прочитаешь свежие данные.
Optimistic replication.
https://en.wikipedia.org/wiki/Optimistic_replication
Lazy replication.
Replicas are allowed to diverge.
Если систему оставить в покое на какое-то время, то реплики сойдутся.

Pessimistic replication - гарантирует что все реплики идентичны.

Система достигшая Eventually Consistencty - Converged.

Если надо копать глубже:
https://en.wikipedia.org/wiki/Linearizability - более строгая модель.

## Basically Available

Reading and writting operations are available as much as possible (using all nodes of a db cluster), but might not be consistent.
Запись может не существовать пока не разрулятся конфликты, и
read читает не самое свежее.

## Soft-State

После какого-то промежутка времени мы имеем не 100% вероятность,
что система converged и мы знаем состояние.

## Eventually consistent

Через какое-то время спокойствия - чтения будут воспроизводимы.

Глубина:
https://en.wikipedia.org/wiki/Safety_and_liveness_properties
https://www.youtube.com/watch?v=HJaI4lCgPCs
Eventually Consistency - это Liveness.

https://ru.wikipedia.org/wiki/%D0%97%D0%B0%D0%B4%D0%B0%D1%87%D0%B0_%D0%B4%D0%B2%D1%83%D1%85_%D0%B3%D0%B5%D0%BD%D0%B5%D1%80%D0%B0%D0%BB%D0%BE%D0%B2

Задача византийских генералов - используется в крипте.
Лояльных генералов должно быть строго больше 2/3.

================================

# Распределенные транзакции

https://en.wikipedia.org/wiki/Distributed_transaction

Two or more network hosts are involved.
Transaction manager - manages this global transaction.

https://en.wikipedia.org/wiki/Two-phase_commit_protocol

Тип протокола консенсуса.
Выбор порядка коммита транзакций.
...

Короче: 1 фаза - атомарная операция по возможности начала транзакции
и блокировки участников коммита.
2 фаза - сбор ответов от участников и применение транзакции с отпусканием блокировок.

================================

**NoSQL - Not Only SQL !!!**