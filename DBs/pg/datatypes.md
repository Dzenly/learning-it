http://www.youtube.com/watch?v=ZKzbsLVRdSc

HSTORE, XML, JSON, JSONB OH MY!


# XML

XML поддерживает XPath.

Валидация.

Есть ф-и для парсинга XML и для проверки.

Supports namespacing.

Можно кастить к тексту.

==================================================

# HSTORE

key/value
strings only
no nested values
GiST, GIN, BTree, Hash indexes
Lost of useful operators.

CREATE EXTENSION hstore;

hstore_to_json

Можно взять ключи и значения.

?? width_bucket.
?? ПОизучать разные функции.

GIN индекс строится медленно.



==================================================

# JSON

Validation on input.

Stored as text.

Preserves white spaces, key orders and duplicates.


::json->2 // array index lookup.

-->>'b' // key index lookup returning text

`#> '{a,b}' path lookup.`

to_json

json_build_array
json_build_object

json_each
json_each_text

json_array_length
object_keys
array_elements
array_elements_text
typeof
to_record

Faster than HSTORE, Slightly more overhead.

Indexing is slower than HSTORE.
Якобы нет GIN и GiST.
Can use expression index.

Stored as text.

Fast IO

Many useful operators.


HSTORE2 ??

Медленноватый SELECT.

============

# JSONB

Binary storage.

supports GIN
all JSON operators.
+ еще кучка полезных операторов.

Parsing overhead.

Bigger then JSON

Select побыстрее, чуть медленнее, чем HSTORE.


Create index 10x faster then for HSTORE

jsoneb_path_ops

===========================

http://www.youtube.com/watch?v=VEHIYYFbwmM

PGDay`14 - 4 июля: Работа со слабо-структурированными данными в PostgreSQL

Слабоструктурированные данные - от лени структурировать.

Жупел - знамя.


Эволюция:

Ключ - значение.
Рэнджи. Сортированные ключ - значения.
Добавились колонки
Documents
Графы.

Смена схемы данных на лету, но быстрая работа.

# HSTORE - бинарное хранение.
Легко добавить новый ключ.
Есть индексы.

JSON появился на три года позже HSTORE.

HSTORE хранится распарсенный, поэтому он быстре JSON, который
нужно парсить.

К томуже HSTORE поддерживает индексы.



JSONB - нет пробелов, нет дупликатов, есть сортировка.

Оверхед по сравнению с текстовыми данными - 4%.

Времена закачки разных данных:

* Text - 34s (as is)
* JSON 37s validation
* JSONB 43s validation, binary storage.


---

Скорость считывания.
Base: 0.6s
Jsonb: 1s
json 9.6s

Есть всякие операторы для того, чтобы шариться внутри JSON и JSONB.

Похоже, кроме GIN (json_ops), JSONB поддерживает и HASH index (json_path_ops, очень быстрый).


Монга поддерживает шардинг.


Почему-то монга в 10ки раз медленнее загружает кучу JSON,
чем PG Jsonb.

ПОиск без индексов - 1 секунда, везде.

GIN PG чуть быстрее, чем B-Tree Mongo.


Индекс монги занимает в в 9 раз больше места,
чем простейший индекс ПГ.

Размер таблиц в Монге в 1.5 раза больше.

Если не нужна гигантская масштабируемость и расширяемость - 
то ПГшные JSONB будут хорошо справляться.

Возможно, при мега-масштабируемости нужно думать о Монге.

Есть сравнение производительности

NoSQL vs Relational

Там есть Redis и Memcached.

=========


JSONB Query

Схемы, констрейнты, поддержка индексов.
jsonb @@

XPath извлекает, JSQuery - ищет.

Ключи в JSONB регистро - зависимые.

jsonb_value-path_ops

jsonb_path_value_ops

Blue Filters ??

======

JSONB не поддерживает статистику (пока что, в 9.4).

А монга имеет оптимизатор.

===========

# VODKA

CREATE INDEX USING VODKA

Heroku - спонсор Vodka.

Пока что много-колоночные индексы не могут
использовать разные типы индексов.
VODKA - позволит это делать.


GIN - искаженное от GINNY - Джин из бутылки??

Есть отдельный Extension - который может в 10 раз
ускорить HSTORE.






















