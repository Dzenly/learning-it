# http://use-the-index-luke.com/sql/preface#

У SQL есть возможность разделять "ЧТО" и "КАК".
Т.е. он говорит "ЧТО" и не говорит "КАК".

Тем не менее, если автор знает как работает БД и индексы он может добиваться лучшей производительности.

Индексация - задача девелопера.

Похоже, книга рассказывает только о B-Tree индексе.

По умолчанию книга рассказывает об Oracle реализации индексов, где надо автор старался делать оговорки для других БД.


Краткое содержание глав:

1. Anatomy of an Index
   Общая структура индексов. Дает представление почему индексы могут быть медленными.

2. Where
   Как ускорять where.

3. Performance and scalability.

4. Join

5. Clustering Data.
Разница между взятием одного столбца или всех.

6. Sorting and Grouping.
   Тут тоже можно юзать индексы.

7. Partial results.

8. Insert, Delete, Update
	Как индексы тормозят эти операции.

Appendixes:

A. - Execution Plans
B. - Myths
C. - Example Schema

=================================


# http://use-the-index-luke.com/sql/anatomy

Индексы создаются by CREATE INDEX statement. Требует куска диска и содержит копии индексированных данных таблицы.
Очень похоже на индексы в конце книг.


```
Clustered Indexes (SQL Server, MySQL InnoDB).
Таблины, состоящие только из структуры индексов.
Index-Organized tables in Oracle.
см. главу Chustering Data: "The second power of Indexing"
```

Индексированные данные упорядочены.

Проблема: как добавлять новые индексы, где искать место под них?
В БД для этого используются double linked list и search tree. 


# http://use-the-index-luke.com/sql/anatomy/the-leaf-nodes

Нужно развязывать физический и логический порядок индексов.


Linked lists используются для связи Leaf Nodes.
Каждый Leaf Node сохраняется в database block or page, i.e. database's smallest storage unit.
Все блоки индексов одинакового размера - несколько килобайт. 

БД использует свободные места в блоках для расширения и сохряняет как можно больше index entries в каждом блоке.

Порядок индексов поддерживается на двух уровнях: index entries within leaf node and leaf nodes amond each other using double linked list.

Язык мутный.

# http://use-the-index-luke.com/sql/anatomy/the-tree

Есть branch nodes, оно хранит значение, максимальное для соответствующего leaf node.
Похоже, leaf node хранит несколько упорядоченных значений колонки и соответствующие RowId.

Автор называет эффективность поиска в B-Tree "**First Power of Indexing**".


# http://use-the-index-luke.com/sql/anatomy/slow-indexes


Переиндексация не улучшает производительность в долгосрочной перспективе.

Причины торможения поиска по индексам:

0. Tree traversal (быстро) Имеет верхнюю границу для количества операций доступа (глубина индекса).
1. node chain внутри node leaf
2. доступ к таблице. Один leaf может ссылаться на кучу RowId, которые могут лежать в разных кусках таблицы (и, видимо, плохо кэшироваться).

Oracle имеет три разных операции, описывающие basic index lookup.

## INDEX UNIQUE SCAN

Только обход дерева. Oracle использует эту операцию, если точно знает, что не больше одной записи соответствует индексу.

## INDEX RANGE SCAN

Tree Traversal + Leaf Node Chain. If multiple entries are possible.

 
## TABLE ACCESS BY INDEX ROWID

Retrieves the row from the table. (Часто) выполняется для каждой найденной записи из предыдущих index scan operation.

Если при INDEX RANGE SCAN получается много результатов, это будет тормозить при выгребании записей из таблицы.

# http://use-the-index-luke.com/sql/where-clause

## http://use-the-index-luke.com/sql/where-clause/the-equals-operator

Concatenated indexes can optimize combined conditions.

### http://use-the-index-luke.com/sql/where-clause/the-equals-operator/primary-keys

БД автоматом создает индекс для primary key.

PRIMARY KEY - подразумевает UNIQUE.

Есть некий Execution plan.

-----

Execution plan. Explain plan. Query plan - synonims.

??
Неуникальные индексы для Primary Key могут быть полезны для отложенных проверок.
Т.е. валидация будет не в процессе исполнения запроса, а отложена до момента коммита.
Это нужно для вставки данных в таблицы с циклической зависимостью.

### http://use-the-index-luke.com/sql/where-clause/the-equals-operator/concatenated-keys

Если первичный ключ состоит из нескольких столбцов, создается concatenated index (multi-column, composine, combined).

Нужно обращать внимание на порядок столбцов.

Трудно отследить косяки в производительности базы в процессе разработки, когда таблицы малы.


Если тянешь много строк, то без индексов быстрее. Т.к. можно считывать пачками.

-----

При ключе на двух колонках.
Сортировка идет по первому индексу. Если они одинаковые - то по второму.

Просто по второму искать не получится.

---

Если сделать, чтобы первым индексом шел наиболее часто используемых. Он будет 


Комбинированные индексы ускоряют. Но одиночные часто лучше. Они занимают меньше места, и лучше производительность при пишуших операциях.

Получается, для хорошего подбора индексов нужно знать и как они работают, и как работает приложение.


### http://use-the-index-luke.com/sql/where-clause/the-equals-operator/slow-indexes-part-ii


**Query Optimizer - трансформирует SQL запрос в Execution plan.**

Cost-based (CBO) Генерит несколько вариантов EP и подсчитывает cost основываясь на количестве операций и количестве обработанных строк.

Rule-based (RBO) Генерит EP с использованием Hard Coded Rule Set. Используются сейчас редко.

В Oracle можно отключать использование индекса в запросе.



> http://www.dba-oracle.com/t_sql_execution_plan_cost_column.htm
Отступление. Есть планы дешевые по CPU, есть по IO, есть те, которые имеют меньшую латентность перед первыми результатами.


>> CBO использует статистику о таблицах, столбцах и индексах. Большая часть на уровне столбцов: количество разных значений, наибольшее и наименьшее значения (data range), кол-во NULL, распределение данных (column histogram).
>> Table size in rows and blocks.
>> 
>> Index stats: tree depth, number of leaf nodes, number of distinct keys, clustering factor.
>> 
>> Optimizer estimates selectivity of the 'where' clause predicates.


В общем, нужно быть осторожным с INDEX RANGE SCAN особенно, когда добавляется доступ к таблице.






