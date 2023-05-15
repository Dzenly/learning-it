# http://www.vertabelo.com/blog/technical-articles/understanding-execution-plans-in-postgresql

Т.е. SQL задает ЧТО нужно, не задавая КАК, есть много путей КАК.

Если встречаешься с торможением, разбор EP может помочь.

EXPLAIN перед SQL Statement.
EXPLAIN SELECT * FROM user;

Это сделать предположение что произойдет.
```
  QUERY PLAN
----------------------------------------------------------
 Seq Scan on users  (cost=0.00..5.24 rows=234 width=41)
```


Чтобы реально выполнить и проанализировать команду:

```
EXPLAIN ANALYZE SELECT * FROM users;
 
                        QUERY PLAN
-----------------------------------------------------------
Seq Scan on users (cost=0.00..5.21 rows=173 width=118)
         (actual time=0.018..0.018 rows=0 loops=1)
 Total runtime: 0.020 ms

```

EXPLAIN работает для:

* SELECT
* INSERT
* UPDATE
* DELETE
* EXECUTE
* DECLARE


Чтобы избежать модификации данных, можно заворачивать EXPLAIN ANALYZE в транзакции.

```
BEGIN;
EXPLAIN ANALYZE ...;
ROLLBACK;
```


```

=> EXPLAIN SELECT * FROM users;
 
                       QUERY PLAN
---------------------------------------------------------
 Seq Scan on users (cost=0.00..5.24 rows=213 width=41)
```

cost=00..5.24 - стартап кост (т.е. действия перед сканом) и общий кост (если все строки будут запрошены) в последовательных доступах к странице.

rows - кол-во строк, если будет выполнение по такому плану.

width - средняя длина строки в байтах.

----

Оптимизатор должен выбрать метод скана и метод джоина.

## Scan methods

### Sequential Scan

Вся таблица. Либо нет индекса, либо оптимизатор предвидит много большой кусок таблицы в ответе.


### Index Scan 

Ищет по B-дереву индексов и по leaf нодам (rande scan ??).
Затем выгребает данные из таблицы.

Работает если есть индекс и оптимизатор предсказывает малое кол-во строк в результате.

### Index Only Scan (since 9.2)

Избегает доступа к таблице, когда база может найти столбцы в индексе.

```
EXPLAIN SELECT firstname, lastname, age FROM users WHERE age = 20 ORDER BY lastname;
                        QUERY PLAN
-------------------------------------------------------------------------------------
Index Only Scan using iusers_multiple on users (cost=0.00..143.21 rows=4087 width=12)
  Index Cond: (age = 20)
```

В примере индекс создан по трем полям, и они каким-то образом есть в индексе сами (т.е. не [?? только ??] номера строк в таблице, а сами значения)

Но индексы занимают больше места.


https://wiki.postgresql.org/wiki/Index-only_scans

Не содержат информации о видимости для текущей транзакции.



http://evtuhovich.ru/blog/2012/10/10/index-only-scan/

explain (analyze true, buffers true) select count(*) from a where first_name = 'Иван';


### Bitmap Index Scan + Recheck + Bitmap Heap Scan

При обычном Index Scan строки из таблицы выбираются в момент нахождения индекса.
А тут номера строк сохраняются в битмапе, потом они сортируются в соответствии с физическим положением.
Получается каждая страница (8 кб по умолчанию в пг) фетчится один раз.

После фетчинга страниц строки перепроверяются на соответствие начальному условию.

Это надо т.к. когда выдергивается большой кусок индекса - 

```
EXPLAIN SELECT firstletter FROM words WHERE firstletter = ’c’;
                        QUERY PLAN
----------------------------------------------------------------------------------------
 
Bitmap Heap Scan on words (cost=3.37..11.54 rows=5 width=3)     Recheck Cond: (firstletter = ’c’::text)
        -> Bitmap Index Scan on iwords_fletter (cost=0.00..4.28 rows=5 width=0)
            Index Cond: (firstletter = ’c’::text
```


## Join methods

Если SQL statement подразумевает JOIN, оптимизатор выбирает алгоритм и очередность.

### Nested loop.

#### with inner sequential scan.

Для каждого элемента?? первой таблицы проверяем каждую строку второй (Sequence Scan), если JOIN condition is fulfilled, the row is returned. Very constly method.

?? What is materialize ??

#### with inner index scan

То же, но по индексам.

#### Hash Join

Создаем хэш от меньшей таблицы на ключе, по которому JOIN.
Т.е. для каждой строки создается Hash и ему соответствует позиция, где сохранена строка. Дальше сканируется большая таблица и в хэше ищутся строки, удовлетворяющие JOIN condition.


Требует памяти, для хранения хэш таблицы.

Мутновато. ?? Нужно почитать про Hash Join в других источниках.

#### Merge Join

Похож на сортировку слиянием.

Обе таблицы сортируются по JOIN аттрибуту. Затем параллельно сканируются обе, и находятся удовлетворяющие условию значения.

Если нет дупликатов, то каждая строка сканится 1 раз. Метод хорош для больших таблиц.


















