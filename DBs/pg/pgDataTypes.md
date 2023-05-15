Отличное видео с плохими слайдами.
http://www.youtube.com/watch?v=Ws95X8g-q5s

Качественные слайды к этому видео.
http://www.slideshare.net/jkatz05/on-beyond-postgresql-data-types

Object Relational DBMS

KNN - GiST ??

CIDR ??
Что-то типа IP.

?? No size constrants for arrays??

Integer Arrays use GIN.

Ranges of different types.
Infinity ranges.


==

SP-GiST

Space Partitioned.

For non - balanced data structures.

k-d trees, guad- trees, suffix trees.
divides search space into partitions of unequal size

Если юзать правильно экономит место, если неправильно - расходует лишнее.

==

?? Scheduling 
Какие-то EXCLUSION CONSTRAINTS.
EXCLUDE USING ...
Don't put this data....
Чтобы избежать дабл букинга.
Т.е. не занимать что-то дважды.

Или чтобы диапазоны не пересекались.


=================

GIN для массивов.

array_replace - глобальная замена.

Есть массивы массивов.

=============

Range types overlapping.

SELECT ('2013-01-08'::date, ... ) OVERLAPS ();

* INT4RANGE (integer)
* INT8RANGE (bigint)
* NUMRANGE (numeric)
* TSRANGE (timestamp without time zone)
* TSTZRANGE (timestamp with time zone)
* DATERANGE (date)

daterange(CURRENT_DATE, CURRENT_DATE)

can be inclusive, exclusive, both.

[2,4)
[2,) -- infinity.

'[1,10]'::int4range

numrange() - defauls to [)

========

SP-GIST хорош для кластеризованных данных.
Для разряженных - наоборот.

==================

CREATE TYPE myRange AS RANGE (SUBTYPE=inet);

=========

hstore - можно вытягивать массив значений по массиву ключей.


hstore поддерживает GIN.

==========

row_to_json


===

По JSON можно построить функциональный идекс, где возвращаемое значени ебудет текстом.


hstore_to_json_loose

=================================












