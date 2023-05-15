http://www.postgresql.org/docs/9.4/interactive/tutorial-arch.html

Есть environment variables (для удаленного сервера):
* PGHOST
* PGPORT 

Имя базы данных - начинается с буквы, и не более 63х байт.
?? Символов или байт ??
Порой удобно называть базу по имени пользователя.

dropdb - нет undo.

## psql утилита - работа из командной строки.

Для суперюзера prompt - #.

 \h
 \q

===================

http://www.postgresql.org/docs/9.4/interactive/tutorial-sql-intro.html

psql \i file.sql

Если порядок вывода при селекте не задан, то он не гарантируется.

Коллекция баз данных на одном сервере - кластер.

### Создание таблицы

CREATE TABLE tableName (colName colType...);

в psql можно вводить команду с разрывами строк.

Вообще в SQL командах можно свободно юзать пробелы, табы, разрывы строк.

-- - коммент до конца строки

SQL нечувствителен к регистру. Ни для ключевых слов, ни для идентификаторов.
Исключение - идентификаторы в двойных кавычках.

varchar(80) - строка длиной до 80 символов.

Стандартные типы:

* int
* smallint
* real
* double
* precision (??)
* char(N)
* varchar(N)
* date
* time
* timestamp
* interval

Поддерживаются и другие типы, богатый набор геометрических типов.
Можно самому определять типы.


=============

### Вставка

INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');

Не числовые константы заключаются в одинарные кавычки.

Для типа *point* можно использовать *'(-194.0, 53.0)'* 


INSERT INTO weather (city, temp_lo, temp_hi, prcp, date)
    VALUES ('San Francisco', 43, 57, 0.0, '1994-11-29');

Порядок следования столбцов неважен если даны их имена.


COPY weather FROM '/home/user/weather.txt';

Используется для засасывания в таблицу файла, лежащего на сервере.

### Выборка

SELECT использует

* select list (перечисление имен столбцов)
* table list (перечисление таблиц)
* qualification (всяческие условия)

Можно использовать выражения и альясы (новое имя столбца):
```sql
SELECT city, (temp_hi+temp_lo)/2 AS temp_avg, date FROM weather;
```

В WHERE можно юзать AND, OR, NOT.

----

SELECT * FROM weather
    ORDER BY city, temp_lo;

SELECT DISTINCT city    FROM weather;

Современный Postgres не гарантирует сортировку при использовании DISTINCT

---

"*" расматривается как не хороший стиль, т.к. добавление к таблицы новых столбцов изменит результат.

===================

Объединение таблиц при запросах.

```
SELECT *
    FROM weather, cities
    WHERE city = name;
```

Указание таблиц для имен столбцов:

```sql
SELECT weather.city, weather.temp_lo, weather.temp_hi,
       weather.prcp, weather.date, cities.location
    FROM weather, cities
    WHERE cities.name = weather.city;
```

Хороший стиль - всегда указывать таблицы при слиянии, чтобы если в таблицах появятся новые поля и они поклешатся, все работало.

```sql
SELECT *
    FROM weather INNER JOIN cities ON (weather.city = cities.name);
```

Чтобы выводить результаты даже когда в какой-то таблице что-то не найдено - OUTER JOIN.

```sql
SELECT *
    FROM weather LEFT OUTER JOIN cities ON (weather.city = cities.name);
```
При LEFT OUTER JOIN - если справа нет - там будут пустоты.

--------

Можно джойнить и с собой (*self join*)

```sql
SELECT W1.city, W1.temp_lo AS low, W1.temp_hi AS high,
    W2.city, W2.temp_lo AS low, W2.temp_hi AS high
    FROM weather W1, weather W2
    WHERE W1.temp_lo < W2.temp_lo
    AND W1.temp_hi > W2.temp_hi;
--Как я понял, AS можно не писать.
```

--

Сокращения
```sql
SELECT *
    FROM weather w, cities c
    WHERE w.city = c.name;
```

===================

## Aggregate Functions

Подсчитывают один результат из множества строк.

count, sum, avg, max, min.
```sql
SELECT max(temp_lo) FROM weather;
```
*Не_могут использоваться в WHERE*, т.к. условия в WHERE выбирают конкретные строки, а значит выполняются перед агрегированием.
Можно использовать *subquery*.

```sql
SELECT city FROM weather
    WHERE temp_lo = (SELECT max(temp_lo) FROM weather);
```


### Агрегатные функции выполняются порционно для GROUP BY.

```sql
SELECT city, max(temp_lo)
    FROM weather
    GROUP BY city;
```

Агрегатные ф-и можно использовать в HAVING.

```sql
SELECT city, max(temp_lo)
    FROM weather
    GROUP BY city
    HAVING max(temp_lo) < 40;
```

Я так понимаю выведутся только удовлетворяющие HAVING группы. 

Комбинация WHERE и HAVING

```sql
SELECT city, max(temp_lo)
    FROM weather
    WHERE city LIKE 'S%'(1)
    GROUP BY city
    HAVING max(temp_lo) < 40;
```

WHERE срабатывает первым, затем GROUP BY, затем HAVING.

*HAVING обычно содержит агрегирующие функции*.

Без агрегирующих функци WHERE работает эффективней.

=======================

## Updates

```sql
UPDATE weather
    SET temp_hi = temp_hi - 2,  temp_lo = temp_lo - 2
    WHERE date > '1994-11-28';
```

## Deletions

```sql
DELETE FROM weather WHERE city = 'Hayward';

DELETE FROM tablename; -- Замочить все строки, никаких предупреждений не будет.
```

=====================

# Advanced features

## Views

Именованный запрос, к которому можно обращаться как к таблице.

```sql
CREATE VIEW myview AS
    SELECT city, temp_lo, temp_hi, prcp, date, location
        FROM weather, cities
        WHERE city = name;

SELECT * FROM myview;
```

Вьюхи позволяет изолировать принципы хранения каких-то данных от программиста.
Как бы предоставление интерфейса, инкапсуляция.

Часто вьюхи делаются поверх других вьюх.

## Foreign Keys

Postgres может сам следит за консистентностью данных между таблицами.

```sql
CREATE TABLE cities (
        city     varchar(80) primary key,
        location point
);

CREATE TABLE weather (
        city      varchar(80) references cities(city),
        temp_lo   int,
        temp_hi   int,
        prcp      real,
        date      date
);
--Now try inserting an invalid record:

INSERT INTO weather VALUES ('Berkeley', 45, 53, 0.0, '1994-11-28');
ERROR:  insert or update on table "weather" violates foreign key constraint "weather_city_fkey"
DETAIL:  Key (city)=(Berkeley) is not present in table "cities".
```

Поведение внешних ключей настраивается.

## Транзакции

Транзакция гарантирует также что операция полностью завершена и в постоянном хранилище новые данные.
Другие конкурентные запросы не видят промежуточного состояния при транзакциях.

BEGIN - начало транзакции
COMMIT - конец транзакции
ROLLBACK - отменить все изменения этой транзакции.

Вообще pg заворачивает все команды в BEGIN/COMMIT.

SAVEPOINT name - точка отката для ROLLBACK TO name.

Можно делать ROLLBACK TO много раз.

Можно сделать RELEASE [SAVEPOINT] name;

ROLLBACK TO и RELEASE освобождают все сейвпоинты после целевого.

До коммита эти манипуляции с сейвпоинтами никак не отражаются на других конкурентных запросах.

При ошибке внутри транзакции она выставляется в aborted state. ROLLBACK TO - восстанавливает рабочее состояние транзакции.

## Window Functions (OVER)

Похоже на агрегирующие ф-и, но результат - кучка строк, как-то связанных с текущей строкой.

*avg(salary) OVER (PARTITION BY depname)*

*OVER (FUNCTION argument)*

```sql
SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
```

Для каждой строки подсчитывается агрегирующая ф-я, по строкам в той же партиции.

OVER (ORDER BY arg ) - порядок обработки строк в партиции. Не обязан быть связанным с порядком вывода.

```sql
SELECT depname, empno, salary,
       rank() OVER (PARTITION BY depname ORDER BY salary DESC)
FROM empsalary;
```

Если опустить PARTITION BY - возьмутся все строки.

*rank()* - порядок в группе (ORDERY BY).


### Window frame

Для каждой строки есть набор строк внутри партиции.
Многие window functions работают только над window frame а не над всей партицией.

Если есть ORDER BY - то в window frame включаются все строки с ранками от 1 до ранка текущей строки.
Если нет ORDER BY - то в window frame (default frame) включаются все строки.

```sql
--Сумма всех зарплат в таблице:
SELECT salary, sum(salary) OVER () FROM empsalary;

--Сумма зарплат с наиболее низкой до текущей:
SELECT salary, sum(salary) OVER (ORDER BY salary) FROM empsalary;
```

Window functions выполняются после WHERE, HAVING, GROUP BY и после агрегатных функций, но до SELECT и ORDER BY.
Можно использовать агрегатные ф-и как аргументы window functions, но не наоборот.


Если нужно заюзать window function в WHERE то это делается подзапросом:

```sql
SELECT depname, empno, salary, enroll_date
FROM
  (SELECT depname, empno, salary, enroll_date,
          rank() OVER (PARTITION BY depname ORDER BY salary DESC, empno) AS pos
     FROM empsalary
  ) AS ss
WHERE pos < 3;
```
*Можно делать альяс для Window Function и переиспользовать его.*
```sql
SELECT sum(salary) OVER w, avg(salary) OVER w
  FROM empsalary
  WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);
```

## Наследование

```sql
CREATE TABLE cities (
  name       text,
  population real,
  altitude   int     -- (in ft)
);

CREATE TABLE capitals (
  state      char(2)
) INHERITS (cities);
```

Возможно множественное наследование.

```
SELECT name, altitude  FROM cities -- все города, включая столицы.

SELECT name, altitude  FROM ONLY cities -- все города, не включая столицы.
```

Многие команды поддерживают ONLY (SELECT, UPDATE, DELETE).

# SQL Syntax

## Lexical Structure

Команда - состоит из токенов, разделенных ";".
В самом конце ";" не обязательно.

Виды токенов:

* key word
* identifier
* quited identifier
* literal (constant)
* special character symbol

Токены разделяются уайтспейсами (space, tab, newline) либо всякими спецсимволами (как я понял, это "=", "()" etc.).
Комментарии - НЕ_ТОКЕНЫ, они равносильны уайтспейсам.

Для команд нет какого-то общего синтаксиса. Для одних синтаксис один, для других - другой.

### Идентификаторы и keywords.

Ключевые слова имеют специальное значение в SQL.
Идентификаторы часто называются "именами".

Полный список keywords:
http://www.postgresql.org/docs/9.4/interactive/sql-keywords-appendix.html

Идентификаторы и keywords должны начинаться с буквы (a-z, но и всякие извратные буквы допускаются) или с подчеркивания.
Не первые могут быть:
* letters
* _
* 0-9
* $ (**Postgres фича, может вызвать несовместимость с другими СУБД**)

Есть соглашение, что SQL стандарт *не_будет_использовать* в keywords:
* цифры
* _ (подчеркивание) в начале и в конце.

Postgres использует по умолчанию первые 63 байта (почему байта а не символа ?? в какой вообще кодировке допускаются идентификаторы??) идентификатора.
Это NAMEDATALEN-1.
По умолчанию NAMEDATALEN = 64.

Keywords и идентификаторы без кавычек не чувствительны к регистру.

Есть соглашение, что keywords пишутся с большой, а идентификаторы с маленькой.

*Любой* (кроме 0 - byte) набор символов в двойных кавычках - идентификатор, даже если совпадает с keyword ("select").

Эти команды аналогичны:
```sql
UPDATE my_table SET a = 5;
UPDATE "my_table" SET "a" = 5;
```
*Двойная кавычка экранируется двойной кавычкой.*

#### Можно использовать юникод: U&"foo"
Если слева или справа от амперсанда будут пробелы, то появится неоднозначность.
Внутри кавычек можно использовать escape - последовательности для юникодных символов:
* \1234
* \+123456

Можно задавать свой символ, чтобы эскейпить юникод.
U&"d!0061t!+000061" UESCAPE '!' -- именно в одинарных кавычках.

Для espape-symbol можно юзать любой одиночный символ, кроме:
* hexadecimal digit
* +
* '
* "
* whitespace

Сам escape-symbol экранируется собой же.

Escape-syntax работает только для энкодинга UTF-8.
Для других энкодингов можно юзать только символы до \007F.
И в 4х цифровой и в 6 цифровой форме можно задавать суррогатные пары, для символов, больших U+FFFF, но это не обязательно, т.к. можно юзать 6-цифровую запись.
Суррогатные пары не сохраняются, в итоге символ переведется в один code point и энкодируется в UTF-8.

Для закавыченных идентификаторов регистр имеет значение, а незакавыченные приводится к lower case.

**Несовместимость: приведение к lower case - фича Postgres. В SQL идентификаторы должны приводиться к upper case.**
Хороший стиль - юзать одно и то же имя одним образом: либо в кавычках, либо без.

## Constants

Есть три неявных типа констант:

* Строки
* Битовые строки
* Числа

Явные типы более точны и быстры.

### Строки

Произвольные символы в *одинарных кавычках*. Одинарная кавычка экранируется собой же.

Если между двумя строками есть newline, то строки сливаются.

```sql
SELECT 'foo'
'bar';
--is equivalent to:
SELECT 'foobar';

SELECT 'foo'      'bar'; -- Ошибка
```

#### C-style escapes

Extension to the SQL standard.
E'foo' (можно e маленькую). Если константа продолжается на другой строке, E юзается только перед первой строкой.
Внутри такой строки работают C-style escapes.

* \b	backspace
* \f	form feed
* \n	newline
* \r	carriage return
* \t	tab
* \o, \oo, \ooo (o = 0 - 7)	octal byte value
* \xh, \xhh (h = 0 - 9, A - F)	hexadecimal byte value
* \uxxxx, \Uxxxxxxxx (x = 0 - 9, A - F)	16 or 32-bit hexadecimal Unicode character value

Другие символы будут восприниматься как есть.
Если на сервере энкодинг - UTF-8, то не надо извращаться с C-Style escapes, нужно юзать unicode escapes.

Unicode escapes работают хорошо если энкодинг сервера UTF-8. Для других энкодингов должны использоваться только code points в диапазоне ASCII.

Для UTF-16 можно пользоваться либо 8-цифровой записью без суррогантых пар, либо 4 или 8 цифровой записью с суррогатными парами.

Когда суррогатные пары юзаются с UTF-8 они превратятся в один code point UTF-8.

Есть настройка *standard_conforming_strings*, по умолчанию "on". Но, если его сделать "off". То эскейп последовательности с бакслэшем будут распознаваться в обычных строках тоже.

Есть ещё параметры escape_string_warning, backslash_quote.

Символ с нулевым кодом не может быть в строке.

#### Unicode Escapes

Выше были идентификаторы, а тут константы.
Тоже самое.
Работает только когда *standard_conforming_strings* == "on", для повышения секюрности, если off - будет ошибка.

#### Dollar-quoted string constants
$tag (zero or more characters)$constant$sameTag$
$$Dianne's horse$$
$SomeTag$Dianne's horse$SomeTag$

Никакие символы не эскейпятся (даже бекспейсы и доллар), строка получается как есть.

Допускается вложенность (при использовании тегов):

```sql
$function$
BEGIN
    RETURN ($1 ~ $q$[\t\r\n\v\\]$q$);
END;
$function$
```
К тегу требования как к unquoted identifier, но он не может содержать $.
Теги case sensitive.

dollar-quoted строки должны быть отделены от keywords пробелами.

Эти виды строк **несовместимы** с SQL стандартом. Но в описании функций очень удобно пользоваться.
При описании ф-и при single-quoted syntax чтобы поставить бэкслеш нужно написать 4 бэкслеша.

#### Bit-string constants

B'1001' -- Нет пробелов, разрешены только 0 и 1.
X'1FF' -- 4 бита на каждую HEX цифру.

$-quoting can not be used  in a bit-string constant.

#### Numeric constants

digits
digits.[digits][e[+-]digits]
[digits].digits[e[+-]digits]
digitse[+-]digits

where digits - 0 - 9.
Перед или после десятичной точки должна быть хотя бы одна цифра.
После e должна быть хоть одна цифра.
Не должно быть пробелов.
Предшествующие знаки  - не часть константы, а оператор.

Примеры: 42, 3.5, 4., .001, 5e2, 1.925e-3

Начальный тип:
Константа без точки и без экспоненты рассматривается как *integer*, если она укладывается в 32 бита,
иначе - *bigint*, если укладывается в 64 бита, иначе - *numeric*.
Константы с точкой или экспонентой рассматриваются как *numeric*.

Можно кастить типы:

```sql
REAL '1.23'  -- string style
1.23::REAL   -- PostgreSQL (historical) style
```

#### Другие типы констант

arbitrary: (?? это такой тип, или они имею в виду, что можно подставить любой тип вместо type)
```sql
type 'string'
'string'::type
CAST ( 'string' AS type )
typename ( 'string' ) -- не для всех типов
```

Явный кастинг можно не делать если неявный начальный тип подходит, или при помещении значения в столбец заданного типа (конвертнется автоматом).
Строковую константу можно описывать либо обычной строкой, либо $-quoted.

::, CAST(), function-call syntaxes можно юзать для конвертации выражений в ран тайме.
type 'string' - можно юзать только для литеральной константы + не работает для массивов (::, CAST() - работают для массивов).

CAST() - часть стандарта SQL.
type 'string' - в SQL используется для нескольких типов, Postgres экстраполировал этот синтаксис для всех типов.
::, function-call - исторически поддерживаемая Postgres - фича.

### Операторы

NAMEDATALEN-1 (63 by default) символов из следующего списка:

```
+ - * / < > = ~ ! @ # % ^ & | ` ?
```

-- и /* не могут идти подряд, т.к. это начало комментов.

Многосимвольный оператор может заканчиваться на + или -, если имя содержит один из следующих символов:

~ ! @ # % ^ & ` ?

Т.е. @- - разрешенный оператор, а *- - нет.

Это позволяет постгресу парсить запросы без пробелом между токенами.

При работе с неSQLстандартными именами операторов нужно отделять смежные операторы пробелами, иначе Постгрес будет думать, что это один оператор.

### Специальные символы

Некоторые не алфанумерик символы имеют специальное значение и они не операторы.

```
$ с последующими цифрами используется для доступа к позиционному параметру (возможно по номеру параметра в функции??) в теле функций или в prepared statement. В других контекстах может быть частью идентификатора или ```$-quoted строк.```

() - (Parentheses) Группировка выражений, изменение приоритетов действий, часть некоторых SQL команд.

[] - (Brackets) Выбор элементов в массивах.

, - (Comma) Между элементами в списке.

; - (Semicolon) Конец SQL команды. Не может быть в команде кроме как в строковой константе или в quited identifier.

: - (Colon) Слайсы массивов. Префиксы для имен переменных в SQL диалектах.

* - (Asterisk) - Все столбцы таблицы или составное значение. Специальное значение как аргумент агрегирующей функции (отсутствие явных параметров).

. - (Period) - В числовых константах, для разделения схемы, таблицы, имени столбца.
```

### Комментарии

-- - до конца строки.
/* */ - Похоже на C-style, но вложенные ведут себя по-другому.

При парсинге комменты превращаются в пробельный символ.

```
/* multiline comment
 * with nesting: /* nested block comment */
 */
``` 
### Приоритеты операторов

Приоритеты < > и <= >= отличаются.

При переопределении оператора приоритеты сохраняются.

| Priority | Operator/Element | Associativity | Description |
|---:| :---------: |:-------:|:--------:|
|1|.| L | table/column name separator |
|2|::| L | Postgres-Style type cast |
|3|[]| L | Array element selection|
|4| + -| R | unary +, unary - |
|5| ^ | L | возведение в степень |
|6| \* / % | L | Умножение, деление, остаток |
|7| + - | L | Сложение, вычитание |
|8| IS | | IS TRUE, IS FALSE, IS NULL, etc|
|9| ISNULL | | test for null |
|10| NOTNULL | | test for not null |
|11| (any other) | L | все остальные, даже юзерские |
|12| IN | | set membership |
|13| BETWEEN | | range containment |
|14| OVERLAPS| | time interval overlap |
|15| LIKE ILIKE SIMILAR | | string pattern matching |
|16| < > | | less than, greater than |
|17| = | R | equality, assignment |
|18| NOT | R | logical negation |
|19| AND | L | logical conjunction |
|20| OR | L | logical disjunction |

?? Есть ли XOR??

Когда юзается оператор с qualified схемой:
OPERATOR(pg_catalog.+)
приоритет как для "any other", независимо что внутри оператора.


### Value Expressions

Результат value expression иногда называется скаляром, чтобы отличить его от table expression result (таблица).
Так что value expressions иногда называются scalar expressions или просто expressions.
В экспрешнах можно юзать разные примитивы, арифметику, операторы.

Виды экспрешнов:

* Константа или литерал.
* Ссылка на столбец
* Ссылка на позиционный параметр (в теле функции или в prepared statement).
* ... TODO

#### Column references

[schemaName.]tableName.columnname

Если имя столбца уникально для всех таблиц, можно опускать имя таблицы.
Вместо имени таблицы может быть альяс.

#### Positional parameters

Используются в функциях и prepared queries. Some client libraries поддерживают задавать данные отдельно от SQL команды, и в этом случае используются ссылки на внешние параметры.

```sql
CREATE FUNCTION dept(text) RETURNS dept
    AS $$ SELECT * FROM dept WHERE name = $1 $$
    LANGUAGE SQL;
```

#### Subscripts

Если результат выражения - массив, до конкретного элемента можно доступиться так:
```expression[subscript]```
Слайс:
```expression[lower_subscript:upper_subscript]```

subscript - это expression, которое резолвится в integer.

Часто array expression заключается в скобки (), но если экспрешн просто ссылка на столбец или позиционный параметр.

```
mytable.arraycolumn[4]
mytable.two_d_column[17][34]
$1[10:42]
(arrayfunction(a,b))[42] /* parentheses are required */
```
#### Field selection

Если результат экспрешна - composite type (row type), до конкретного поля доступаемся через точку:
expression.fieldname

Опять, скобки могут быть опущены, когда экспрешн - таблица или позиционный параметр.
```
table.mycolumn
$1.somecolumn
(rowfunction(a,b)).col3
```
Есть композиционный тип, и синтаксис доступа к его подполям такой:

```
(compositecol).somefield
(mytable.compositecol).somefield -- скобки, чтобы показать, что это имя столбца а не таблицы или схемы.
```
Можно взять все поля композитного типа с помощью *

(compositeCol).*

#### Operator invocation

* expression operator expression (binary infix operator)
* operator expression (unary prefix operator)
* expression operator (unary postfix operator)

AND, OR, NOT - это операторы, можно также задавать оператор с квалификацией 
```OPERATOR(schema.operatorname)```

#### Function calls

```function_name ([expression [, expression ... ]] )```

sqrt(2)

Ф-я, берущая один аргумент композитного тип может опционально быть вызвана с использованием field.selection syntax и наоборот, field-selection может быть написан в функциональном стиле. Т.е. col(table) и table.col - взаимозаменяемы.
Это не SQL стандарт, эта фича pg, позволяющая эмулировать computed fields.

#### Aggregate Expressions

Применяет агрегирующую ф-ю на выбранные строки.

```
1. aggregate_name (expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ]
-- Запускает аггрегацию один раз для каждой строки.

2. aggregate_name (ALL expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ]
-- Запускает аггрегацию один раз для каждой строки. ALL подразумевается по умолчанию.

3. aggregate_name (DISTINCT expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ]
-- Запускает аггрегацию один раз для каждого уникального значения выражения или уникального набора значений (для множества выражений).

4. aggregate_name ( * ) [ FILTER ( WHERE filter_clause ) ]
-- once for each row. Нет конкретного входного значения. Можно использовать в count(*).

5. aggregate_name ( [ expression [ , ... ] ] ) WITHIN GROUP ( order_by_clause ) [ FILTER ( WHERE filter_clause ) ]
-- используется с ordered-set агрегирующими функциями, они описаны ниже.
```

(?? Т.к. в данный момент я не знаю некоторых ключевых слов, особо в синтаксис не вникаю, просто перевожу и резюмирую).

aggregate_name - может квалифицироваться схемой.
expression - не содержит aggregate expressions или window function call (определяется ниже).

Большинство агрегирующих функций игнорят null inputs. Если какая-то агрегирующая функция учитывает null input - это описано в доках к ней.
Например, 
* count(*) - количество всех входных строк.
* count(f1) - кол-во строк, где f1 not null.
* count(distinct f1) - кол-во разных not null values.

Обычно порядок скармливания строк АФ (агр. ф-ю) не задан.
Но, некоторые ф-и чувствительны к порядку (*array_agg, string_agg*), поэтому *order_by_clause* (синтаксис как у query-level ORDER BY, ??но нельзя юзать выходные имена столбцов и числа??)

```
SELECT array_agg(a ORDER BY b DESC) FROM table;

-- ORDER BY идет после всех аргументов:
SELECT string_agg(a, ',' ORDER BY a) FROM table;
-- После первого ORDER BY агрумента, все аргументы дальше считаются ORDER BY.
```

У пг есть экстеншн. Возможность задавать и *DISTINCT* и *order_by_clause*. В этом случае все ORDER BY должны соответствовать обычным аргументам АФ. Т.е. нельзя сортировать по экспрешну, не включенному в DISTINCT.

Пока что были примеры, когда ORDER BY в аргументах АФ опционален.

Есть ordered-set АФ, для которых *order_by_clause* - обязательно, т.к. агрегирование имеет смысл только для заданного порядка.
Примеры: rank, percentile.
Для ordered-set АФ *order_by_clause* пишется так ```WITHIN GROUP (*order_by_clause*)```.
Выражения в *order_by_clause* вычисляются раз на каждую строку, как обычные аргументы, сортированные *order_by_clause*,
и скармливаются в АФ как входные аргументы. Если не использовать WITHIN GROUP - тогда ORDER BY не будет рассматриваться как аргумент.
Аргументы до WITHIN GROUP (если есть) называются *direct arguments*, чтобы отличать их от *aggregated arguments*, перечисленных в *order_by_clause*.
В отличие от обычных agregate arguments, **direct arguments подсчитываются только раз на вызов АФ, а не раз на строку**.
Они могут содержать только сгруппированные через GROUP BY переменные. Это тоже самое, как если бы direct arguments были вне aggregate expression. Например, percentile fraction - имеет смысл как одно значение на весь агрегированный подсчет.
Direct argument list может быть пустым. В этом случае нужно писать (), а не (*). PG примет любой синтаксис, но только первый SQL-standard-compliant.

Пример ordered-set АФ запроса:
```
SELECT percentile_disc(0.5) WITHIN GROUP (ORDER BY income) FROM households;
```

Если задан FILTER, только строки, для которых filter_clause == true скармливаются АФ:
```
SELECT
    count(*) AS unfiltered,
    count(*) FILTER (WHERE i < 5) AS filtered
FROM generate_series(1,10) AS s(i);
```

Aggregate expression нельзя юзать в WHERE (т.к. WHERE используется до получения результатов), но можно в HAVING.

Когда aggregate expression находится в подзапросе, агрегирование происходит по строкам подзапроса.
Есть исключение, если аргументы и filter_clause (если есть) содержат только внешние переменные: тогда агрегирование выполняется над строками самого вложенного запроса, откуда взята внешняя переменная.
Тогда aggregate expression в целом является внешней ссылкой для подзапроса, где оно находится (?? что за муть ??), и работает как константа для любого вычисления этого подзапроса. Ограничения на полявление только в результатах запроса или в HAVING применяется относительно уровня запроса, где вызов АФ.

### Window Function Calls

Применение ф-й, похожих на агрегатные к порции строк, выбранных запросом.
В отличие от обычных агрегатных функций, они не связаны с группировкой строк в одной значение (одну выходную строку), каждая строка остается отдельной в результатах запроса. Однако ВФ (window function) может сканировать все строки текущей группы строк, в соответствии с PARTITION BY list.

```
1. function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER window_name
2. function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
3. function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER window_name
4. function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
```





==============
