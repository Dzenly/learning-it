# http://postgresguide.com/performance/indexes.html

Если нет индексов - будет последовательное сканирование.

Индексы замедляют вставку, т.к. происходит обработка (например, сортировка).
Нужно подбирать тип индекса для заданного типа данных.


Можно создавать индекс по нескольким столбцам.


CONCURRENTLY - позволяет не лочить таблицы при создании индекса.

Если вам часто нужен значительный кусок таблицы - индексы могут замедлять работу.

PG не создает индексы для Foreigh Keys по умолчанию. Если надо - сделай сам.

=====================================

# http://www.tutorialspoint.com/postgresql/postgresql_indexes.htm

Индексы можно создавать и удалять без эффекта на данные.

Индексам можно задавать имя.

ASC, DESC.

Индекс можно сделать уникальным, тогда он будет запрещать дупликацию комбинаций значений в столбцах.

UNIQUE.

Типы индексов:

B-tree (default), Hash, GiST, SP-GiST, GIN.

```
CREATE INDEX index_name
ON table_name (column1_name, column2_name);
```

---

## partial 

Есть предикат, задающий что нужно индексировать.

```
CREATE INDEX index_name
on table_name (conditional_expression);
```

## Implicit

Автоматом индексы создаются для Primary key и Unique.

\d table - распечатывает инфо о таблице, включая индексы.

---

DROP INDEX salary_index;

## Где индексы неэффективны

* Мелкие таблицы.
* Частые вставки.
* Выгребание значительных кусков таблицы.
* Очень много NULL в столбцах.


==========================================================================

# http://leopard.in.ua/2015/04/13/postgresql-indexes/


Есть последовательно нумеруемый RowId.
Т.е. таблица это список пар (RowId, row).
В индексе строка должна содержать хотя бы одну ячейку.
Если строки неуникальны - одному индексу будет соответствовать несколько строк.

* Data search. ВСЕ индексы поддерживают поиск по одинаковости. Некоторые по префиксу "abc%" ?? и по диапазону.
* Optimizer. ?? B-Tree and R-tree indexes represent a histogram arbitrary precision ??
* Join. ?? Indexes can be used for Merge, Index algorithms ??
* Relation. Indexes can be used for except/intersect operations
* Aggregations. Indexes can effectively calculate some aggregation function (count, min, max, etc).
* Grouping. Indexes can effectively calculate the arbitrary grouping and aggregate functions (sort-group algorithm).

-------

## Типы индексов.

### B-Tree (Default)

Balanced - кол-во данных с двух сторон дерева примерно одинаковое.
Могут использоваться для equality and range queries. Работают со всеми типами данных, включая NULL.
Хорошо работают с кэшированием, даже с частичным.

#### Плюсы

* Данные отсортированы.
* ?? Поддерживаются унарные и бинарные предикаты.
* ?? Allow the entire sequence of data to estimate cardinality (number of entries) for the entire index (and therefore the table), range, and with arbitrary precision without scanning

#### Минусы

* Нужна сортировка при создании (медленная операция)
* Нужно место на диске.
* Запись нарушает баланс дерева, ??данные?? начинают хранится разряженно.
  Нужен переодический ребилдинг.

### R-Tree (Rectangle Tree)









