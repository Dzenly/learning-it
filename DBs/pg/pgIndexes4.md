http://www.slideshare.net/jkatz05/explain-the-index-of-postgresql-indexes?from_action=save

# B-Tree

поддерживает LIKE в специфичных случаях: 'plaintext%'.
~ - '^plaintext'
`ILIKE and ~* if pattern starts from nonaplha char`

Does no support IS NOT DISTINCT FROM

Подходит для типов данных, поддерживающих все операции сравнения.
Числовые типы.
Текст.
Время, даты.
arrays, ranges.

====

Вакуум подчищает и индексы тоже.

Есть команда REINDEX.

FILLFACTOR - обратить внимание.
При частой записи - увеличивать.

?? Что такое TABLESPACE, NULLS LAST, NULLS FIRST

===

UNIQUE INDEXES (инфа за Ноябрь 2013):

Только для B-Trees.
NULL - not unique.
**UNIQUE constraint automatically creates indexes.**

Multi column indexes.
Если хочется ускорить мультиколоночные запросы или сделать мульниколоночную уникальность.
Внимание к порядку колонок.


=========

Expression indexes slower writes.
Можно юзать с любыми типами, если в результате будет поддерживаемый индексами тип.

=========

Геометрические типы поддерживают преобразования, проверки на взаимное расположение, пересечение, расстояние, нахождение центра, и т.д.

=========

GiST - поддерживают также конкуррентное создание и логирование.

?? What is Lossless and sossy indexes ??

Поддерживает nearest neighbor (KNN-GiST).

Для геом типов данных индекс может быть очень большой. (раз в 20 превышать размер таблицы без индексов).


PostGIS юзает комбинацию GiST + R-Tree.


===

FTS - Full Text Search.

to_tsvector
to_tsquery
=============


GiST для FTS может давать false positives. Это может снижать производительность.


===============

GIN

Arrays, Full Text Documents, hstore.
(я думаю, что JSON и JSONB тоже)

Производительность log(#unique things)

Производительность раз в 10 лучше GiST.

Приемлемый размер.

Проигрывает GiST при записи.

?? Имеет FASTUPDATE.
9.4 - сжимается.

==========

RegExp.

pg_trgm + GIN.



============

Range types - расширяемые.
Поддерживают GiST.


?? What means generate_series(1, <N>) ??


Для range types важно выбрать между GiST и SP-GiST.
Clustered vs Sparse.

What means UNLOGGED ??
CREATE UNLOGGED TABLE.
Не заморачиваться WAL, вроде это должно ускорять.

===

HASH индексы не записываются в WAL ??




What is btree_gin ??

Gin over btree - if a lot duplicates.

==========

Внимательно относимся к оператору @> / <@.
При безобидном переворачивании выражения, индексы могут перестать использоваться.

===================

http://www.slideshare.net/hansjurgenschonig/postgresql-advanced-indexing?from_action=save

=========

DROP INDEX * - интересно, а почему не как table ?
Чисто, чтобы проверять семантику ?

===

* seq_page_const - 1
* random_page_cost - 4 // Can be corrected to 1 for SSD.
* cpu_tuple_cost - 0.01
* ?? cpu_operator_cost - 0.0025
* ?? cpu_index_tuple_cost = 0.005

====

pg_relation_size
pg_total_relation_size


===

tablespace - отдельная дисковая директория для таблиц.
Что-то можно разместить на SSD, что-то на RAMDrive.

CREATE TABLE foo(i int) TABLESPACE space1;
SET default_tablespace = space1;
CREATE TABLE foo(i int);


temp_tablespaces - для всяких временных штук, например, при сортировке.

alter tablescape pg_default set (random_page_cost=1);
----------

CLUSTER - cluster a table according to an index.


=======

B-Tree обеспечивает порядок.

===

citext extension.


=============

GiST типа по другим принципам, чем B-Tree.
?? Внутри R-Tree ??

Supports contains, left of, overlaps.

Allows KNN search.

contains for FTS, Geometric, Ranges, Fuzzy search.

?? Fuzzy search ??

===

Можно писать свой парсер для текста.

FTS очень гибок. Словари, Шаблоны, Парсеры, и т.д.


=========

Классы операторов.
Видимо каждый тип имеет свой набор операторов.

Создание оператора CREATE OR REPLACE FUNCTION.
CREATE OPERATOR
CREATE OPERATOR CLASS

============

Tragrams
pg_trgm

Fuzzy matching (когда не знаешь точного написания какого-нибудь названия).
KNN search.

CREATE INDEX ... ON ... USING gist(... gist_trgm_ops);

Наверное, что-то типа кол-ва совпадющих букв.

============

SET enable_seqscan TO off;

min max - index scan, index backward scan.


===========

http://www.slideshare.net/fuzzycz/performance-improvements-in-postgresql-95-and-beyond?qid=496ac0a1-048b-4e93-b096-d42c25391847&v=default&b=&from_search=12

BRIN Block Range Indexes.

========

Возможно, стоит пересобрать с новейшим компилятором, чтобы задействовать все возможности окружения.
(именно на той машине, на которой буду работать).

==========

?? 9.6 + TableSample ??

==========

http://www.slideshare.net/profyclub_ru/postgre-sql-14823905?qid=496ac0a1-048b-4e93-b096-d42c25391847&v=default&b=&from_search=30

FTS
E-FTS ??

=============

BRIN
http://www.postgresql.org/docs/devel/static/brin-intro.html

Block Range Index.

Сохраняет диапазон значений столбца для кучки блоков данных.
(Как я понял, например, для страниц).

Для очень больших таблиц, где значение какого-то столбца корредирует с с физическим положением в таблице.
Block range - группа страниц, физически смежных в таблице. Для каждого BR некое Summary Info сохраняется индексом.
Например, даты.
Таблица с Зип кодами, коды могут быть сгруппированы в рамках одного города.


BRIN - lossy index.
Это когда индекс может содержать false matches, и нужно подтверждать чтением строки из таблицы.

Bitmap может применяться, чтобы отсеять строки, точно не содержащие нужного результата.

Операторы могут сохранять минимального/максимальное значения для каждого Block Range.
E.g. bounding box.











































