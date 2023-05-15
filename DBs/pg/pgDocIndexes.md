# http://www.postgresql.org/docs/9.5/static/indexes.html

```
CREATE INDEX test1_id_index ON test1 (id);
```

id - имя столбца.

DROP INDEX


?? But you might have to run the ANALYZE command regularly to update statistics
Я думал, что статистика и без ANALYZE копится.

Индексы могут ускорять и UPDATE/DELETE/JOIN т.к. ускоряют поиск.

PG позволяет читать из таблицы во время создания индекса, но запись блокируется на время создания индекса.
Но с некоторой осторожностью можно использовать конкуррентное создание индексов.

Нужно мониторить использование индексов, неиспользуемые индексы вредны.

# http://www.postgresql.org/docs/9.5/static/indexes-types.html


## B-Tree

По умолчанию создается B-Tree.
Хорошо подходит для данных, которые можно отсортировать.
Используется при операциях сравнения и их эквиваленнтах (BETWEEN, IN), IS NULL, IS NOT NULL.

Также для C locale может использоваться для pattern-matching (LIKE, ~).
Для не C locale нужно создать operator class (http://www.postgresql.org/docs/9.5/static/indexes-opclass.html).

```
ILIKE / ~* работают с индексами только если паттерн начинается с non-alpha character (т.е. не изменяется при upper/lower)
```

B-tree индексы используются для получения отсортированных данных, правда, это не всегда быстрее, чем простое сканирование и сортировка.

## Hash

`CREATE INDEX name ON table USING HASH (column);`

Используются для equality comparisons.

**Пока что их использовать не рекомендуется. Есть несколько проблем.**

## GiST (Generalized Search Tree ?? )
Инфраструктура. 

Здесь доп. инфа: 
* http://www.postgresql.org/docs/9.5/static/textsearch-indexes.html
* http://www.postgresql.org/docs/9.5/static/gist.html

Стандартная поставка PG включает GiST operator classes для двумерных геометрических фигур.
Есть ещё много операторов.

Позволяют оптимизировать поиск ближайших соседей.

`SELECT * FROM places ORDER BY location <-> point '(101,456)' LIMIT 10;`

## SP-GiST (Space/Spatial-Partitioning Search Trees)

Тоже дает 


# http://www.postgresql.org/docs/9.5/static/sql-createindex.html#SQL-CREATEINDEX-CONCURRENTLY

