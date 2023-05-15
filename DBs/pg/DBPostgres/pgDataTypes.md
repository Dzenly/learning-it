[TOC]
# Data Types

## Numeric

* smallint (2 bytes, signed)
* integer (4 bytes, signed)
* bigint (8bytes, signed)
* decimal (variable, exact) - до 131072 цифр перед точкой и до 16383 после.
* numeric (variable, exact) - до 131072 цифр перед точкой и до 16383 после.
* real (4 bytes) - точность до 6 десятичных цифр.
* double/precision (8 bytes) - точность до 15 дес. цифр.
* smallserial (2 bytes, autoincrementing integer)
* serial (4 bytes, autoincrementing integer)
* bigserial (8 bytes, autoincrementing integer)

Эти типы имеют полный набор арифметических операторов и ф-й.

### Integer

При попытке записать значение, не входящее в ранг, будет ошибка.

int2, int4, int8 - extensions of SQL standard.

### Произвольная точность

Требуется, например, для денежных сумм, где нельзя потерять ни копейки.
Тормозной.

*scale* - кол-во десятичных цифр в дробной части.
*precision* - количество цифр всего.

max scale and max precision - are configurable.

NUMERIC(precision, scale) -- max precision for explicit declaration - 1000
NUMERIC(precision) -- scale = 0 
NUMERIC -- precision and scale do not coerce, максимальные значения, как в таблице выше.

SQL стандарт требует дефолтный scale - 0, т.е. приведение к целому. Pg команда считает это бесполезным. Чтобы быть SQL совместимым - жестко задавай параметры.

При приведении к типам происходит округление до scale, указанной для явного типа. Дальше, если на левую часть осталось меньше чем надо - ошибка.

Даже при явном определении типа, для хранения используется разное количество байт. 2 байта на каждые 4 значащие цифры + от 3х до 8ми байт какой-то оверхэд.

Есть значение 'NaN' (case insensitive). Любые операции над NaN дают NaN.

UPDATE table SET x = 'NaN';

Обычно NaN не равен ничему, даже самому себе.
Для целей сортировки pg считает NaN равными и больше любого другого числа.

Типы decimal и numeric - эквивалентны и SQL-стандартны.

### Floating-Point types.

float и double - обычно имплементации стандарта IEEE 754 (в той мере, в какой платформа его поддерживает).

=====================
Выдержка из стандарта:
Есть мантиса и экспонента.
Число нормализовано, если мантисса в диапазоне от 1 до 9.
Экспонента состоит из основания системы и порядка.
Порядок может быть отрицательным.

Число денормализовано, если 0.1 <= мантисса < 1.

155,625 -> 10011011,101

===

32 битное кодирование:
Бит знака - самый старший.
Дальше идет байт экспоненты, экспонента хранится  в виде 127 + экспонента.
Т.е. при преобразовании байта в экспоненту нужно отнять 127.
И экспонента эта двоичная, т.е. на сколько бит сдвинута мантисса (а не в какую степень 10ки надо возводить).
Дальше идут 23 бита мантиссы.
Т.е. первый бит у нормализованной двоичной мантиссы всегда 1.

64-bit:

Смещ. экспонента: 11 бит (смещение 1023).
Остаток мантиссы: 52.

=====================

Нужно быть осторожным при использовании неточных типов:

* Сохраняется не то, что записываешь.
* При сравнении неожиданные результаты.
* Следи за переполнением.

NaN - 0x7fffffff
+-Infinity - 0x7f800000/0xff800000

Слишком мелкие и слишком крупные значения вызовут ошибки (underflow / overflow).
float - минимальная точность - 6 знаков, диапазон 1E-+37.
double - 15 Знаков, 1E-307 - 1E+308.

Есть параметр ```extra_float_digits``` - добавляет значащие цифры при конвертации в текст. Дефолтное значение - 0, совместимо со всеми платформами. Если увеличить, то хранимые значения будут распечатываться точнее, но будет несовместимость.

float(p) - p - минимальная pricision в двоичных цифрах. float(1) - float(24) - real type. float(25) - float(53) - double type.
Если p вне допустимого интервала - ошибка. Просто float - означает double.

Некоторые платформы не поддерживают IEEE 754, всякие NaN и Infinity могут не работать.
(Infinity - тоже case-insensitive)
На этих платформах на мантису может тратиться меньше указанных float(p), но для простоты выбор типа не зависит от платформы.

### Serial types

Это не честные типы, а удобное создание уникальных идентификаторов (похоже на AUTO_INCREMENT  в других бд).

```
CREATE TABLE tableName(colname SERIAL); -- Аналогично, сиквенс удалится, при удалении столбца.
-- эквивалентно:
CREATE SEQUENCE tablename_colname_seq;
CREATE TABLE tablename (
    colname integer NOT NULL DEFAULT nextval('tablename_colname_seq')
);
ALTER SEQUENCE tablename_colname_seq OWNED BY tablename.colname; -- Сиквенс удалится при удалении столбца.
```

При удалении сиквенса удалится DEFALUT для столбца.

?? SEQUENCE ??
?? sequence generator ??

UNIQUE / PRIMARY KEY- Запретят использовать значение, которое уже было.

## Monetary types

Тип *money* - фиксирована дробная точность, определяется настройкой lc_monetary.
На тип идет 8 байт, если в дробной части 2 цифры, диапазон будет:

-92233720368547758.08 to +92233720368547758.07 (17 цифр до точки, 2 после).

Входные данные могут быть, например, в integer, floating-point, ```'$1,000.00'```.  Выходные данные зависят от локали (перед переносом данных из одной базы в другую - сделай lc_monetary одинаковыми), обычно ```'$1,000.00'```.
numeric, int, bigint кастятся к money. float и double precision могут сначала каститься к numeric, но использовать типы с плавающей точкой не рекомендуется из-за потенциальных проблем с округлением и точностью.
Т.е. нельзя сразу откастить из float в money, нужно сначала в numeric:
```SELECT '12.34'::numeric::money;```
money кастится к numeric без потерь точности, в другие типы кастится с потенциальной потерей точности

Конвертация money -> float должна идти также через numeric.

При делении money типов получается double.

## Character Types

*character varying(n), varchar(n)* variable-length with limit
*character(n), char(n)* fixed-length, blank padded
*text* variable unlimited length (non SQL standard, but many DB support it)

Если символов больше чем n и они не пробелы - при записи в таблицу будет ошибка. Если после трункации пробелов длина влезает - ок (SQL-standard behavior).
character(n) - добивается пробелами до полной длины, varchar(n) - не добивается.

При явном кастинге длинные строки обрезаются без ошибок (SQL-behavior).

character - без указания длины = character(1).
varchar - без длины - любая длина (pg extension).

trailing spaces не учитываются при сравнении типов character/char, в коллейшнах, где уайтспэйсы значимые - будут неожиданные результаты.

Уайтспэйсы значимы в varchar, text и при использовании в LIKE и regexps.

Тогда не понимаю почему:
```SELECT 'a '::VARCHAR(2) < 'a\n'::VARCHAR(2);``` - true.

Длина коротких (до 126 байтов) строк - 1 байт + строка. В байте длины учитываются и padding whitespaces.
Более длинные строки уже хранят 4 байта на длину. Длинные строки автомат сжимаются, так что на диске могут требовать и меньше места.

Очень длинные значения хранятся в фоновых таблицах (??), так что они не мешают быстрому доступу к коротким полям.
Строки могут занимать не более примерно 1 GB. Символ может занимать более 1 байта.
Хочешь юзать совсем неограниченные строки - юзай text.

Особой разницы в производительности между этими 3мя типами нет. Разве что заполнение пробелами - неэффективно расходует место.
А также CPU cycles для определения длины length-constrained column (?? а для не length-constrained циклы цпу не нужны ??).

В некоторых БД character(n) имеет небольшие performance advantages, в pg - нет, наоборот, из за оверхедов на хранение пробелов это самый медленный тип.

Короче, лучше не юзать char(n)/character(n). ?? Разве, что, когда точно нет пробелов, наверно, для всяких md5, например ??

Есть ещё два внутренних fixed length типа: "char" - однобайтовый внутренний тип, name - 64-байтовый (верней NAMEDATALEN-байтовый) (один байт - на терминатор, так что на реальную длину идет NAMEDATALEN - 1). Эта константа задается при компиляции пг и может поменяться в будущих релизах.

Тип "char" (кавычки важны), отличается от char(1), потому что использует 1 байт. Используется в системных каталогах для перечислений.

## Бинарные типы

bytea - бинарная строка с произвольной длиной. От 1 до 4х байт на длину.
Отличается от символьных тем, что позволяет октеты с нулем, non-printable octets и другие октеты, которые не разрешаются в выборанном энкодинге.
Операции над битовой строкой не зависят от настроек локали.

Есть два формата представления бинарных строк. Escape и Hex (с 9.0.0).
На входе могут быть любое, на выходе - настраивается через bytea_output (default: hex).

SQL стандарт дефайнит BLOB, входной формат отличается от bytea, но ф-и очень похожи.

### Hex

По одной hex digit на каждый полубайт (старший - первый). Перед всех строкой \x (чтобы отличать от escape format).
Пробелы разрешены только между байтовыми парами.
Этот формат универсальней и быстрее Escape формата.
```SELECT E'\\xDEADBEEF';```

### Escape

Можно использовать, когда представление байтов как символов имеет смысл, но тогда можно рассмотреть использование символьных типов.
В общем, для современных приложений трудно придумать случай, когда этот формат нужен.
Некоторые октеты можно *эскейпить*, а некоторые *нужно*.

Октеты кодируются бэкслэшем (или двумя, первый для парсера строки, второй для парсера bytea в базе) и тремя восьмеричными цифрами.
Требование эскейпить или нет непринтабельные октеты может зависеть от локали.

Непринтабельные октеты конвертятся в ескейп последовательности при выводе. Большинство принтабельных октетов - представляются в клиентском энкодинге. Бэкслеш - дублируется.


## Date time types

Даты считаются по Грегорианскому календарю.

* timestamp(p) without time zone / 8 bytes / 
* timestamp(p) with time zone / 8 bytes /
* date / 4 bytes / (только дата, без часов и т.д.)
* time(p) without time zone / 8 bytes / (только время без даты)
* time(p) with time zone / 12 bytes / (только время без даты)
* interval(p) / 16 bytes / 

В SQL стандарте timestamp - без TZ.
Pg имеет  extension: timestamptz

p - precision, количество десятичных цифр после точки (0 - 6).
По умолчанию нет границ точности. (??)
*timestamp* - кол-во секунд после 2000-01-01:00:00:00

Есть deprecated floating-point или double precision формат хранения дат. Он допускает больший диапазон, но меньшую точность, которая деградировала по мере удаления от 2000-01-01.

Для восьмибайтового хранения - точность от 0 до 6, либо от 0 до 10 если floating-point.

interval имеет возможность настраивать набор сохраняемых полей:

* YEAR
* MONTH
* DAY
* HOUR
* MINUTE
* SECOND
* YEAR TO MONTH
* DAY TO HOUR
* DAY TO MINUTE
* DAY TO SECOND
* HOUR TO MINUTE
* HOUR TO SECOND
* MINUTE TO SECOND

Если интервал использует p, значит SECOND нужно выбрать тоже.

time - SQL стандарт с TZ, 

Есть типы abstime, reltime, они имеют меньшую точность и юзаются внутри, юзать не надо, могут исчезнуть в будущих релизах.

#### Date / Time input

Вводить дату и время можно в любом формате.

DateStyle параметр задает формат ввода даты.

type [ (p) ] 'value' -- если precision не задан, точность берется из литерала.
Если TZ задается для типа, который не поддерживает TZ, - это тихо игнорится. Дата используется для типов с поддержкой daylight-saving rule.
PST = UTC - 8.

SQL стандарт определяет начиличе TZ по знаку "+" или "-" после времени дня.

```TIMESTAMP '2004-10-19 10:23:54+02'```

**НО**, пг это не проверяет, поэтому для TZ нужно юзать такой синтаксис:

```TIMESTAMP WITH TIME ZONE '2004-10-19 10:23:54+02'```

Timestamp с TZ внутри хранится в UTC.

Если TZ не задана явно, как TZ используется TimeZone.

При выводе конвертится из UTC в current TZ. Чтобы передвинуть на другую TZ - юзай: AT TIME ZONE.

Преобразование (может имели в виду сравнение??) из timestamp w/o TZ и timestamp with TZ предполагается, что w/o TZ - в локальной TZ.
Можно юзать ```AT TIME ZONE```. 

### Special input values

* 'infinity' / '-infinity' - (date, timestamp) специальные числа (позже чем любая дата, раньше чем любая дата) Не преобразовываютя в конкретную дату.
* 'epoch' - (date, timestamp) 1970-01-01 00:00:00+00 (Unix system time zero)
* 'now' - (date, time, timestamp) - время начала текущей транзакции
* 'today' - (date, timestamp) midnight today
* 'tomorrow'- (date, timestamp) midnight tomorrow
* 'yesterday' - (date, timestamp) midnight yesterday
* 'allballs' - (time) 00:00:00.00 UTC

Следующие SQL-совместимые ф-и для получения текущего времени для разных типов данных, их нельзя применять в input strings:

p - точность.

* CURRENT_DATE
* CURRENT_TIME(p)
* CURRENT_TIMESTAMP(p)
* LOCALTIME(p)
* LOCALTIMESTAMP(p)

### Date/Time output

* ISO (default): "1997-12-17 07:37:16-08"
* SQL: "12/17/1997 07:37:16.00 PST"
* Postgres: "Wed Dec 17 07:37:16 1997 PST"
* German: "17.12.1997 07:37:16.00 PST"

Принимает буквы T как разделитель между датой и временем. Но на выходе не показывает её.
Стиль следования дня, месяца и года можно задавать настройками:

* SET datestyle - in command
* DateStyle - in postgresql.conf
* PGDATESTYLE - in environment variable

Есть ещё ф-я to_char для форматирования date/time output.

### Time Zones

PG uses IANA TZ database.

Две очевидные проблемы SQL стандарта:

* Тип date не может иметь TZ, но time может. TZ применяются для time, зависимо от date из-за daylight-saving time.
* Дефолтная TZ определяется как постоянное числовое смещение от UTC. Невозможно использовать DST при date/time арифметике через границы DST.

Чтобы избежать сложностей можно юзать типы, содержащие и date и time, когда используешь TZ, и не юзать просто time.

TZ можно задавать тремя способами:

* Полное имя. Можно глянуть в *pg_timezone_names*. Подразумевает DST rules.
* Аббревиатура.  Например, PST, задает смещение, но не DST. *pg_timezone_abbrevs*. Аббревиатуры нельзя использовать в TimeZone и log_timezone параметрах, но можно использовать во входных значениях с помощью оператора AT TIME ZONE.
* POSIX-style в форме STDoffset, STDoffsetDST, где STD - аббревиатура зоны, offset - числовое смещение в часах на запад от UTC, DST - опциональная аббревиатура для DST зоны (на один час впереди заданного смещения??).

....
.... TODO: какая-то муть.

### Interval input

* *1-2* SQL standard format: 1 year 2 months
* *3 4:05:06* SQL standard format: 3 days 4 hours 5 minutes 6 seconds
* *1 year 2 months 3 days 4 hours 5 minutes 6 seconds*	Traditional Postgres format: 1 year 2 months 3 days 4 hours 5 minutes 6 seconds
* *P1Y2M3DT4H5M6S*	ISO 8601 "format with designators": same meaning as above
* *P0001-02-03T04:05:06*	ISO 8601 "alternative format": same meaning as above

### Interval Output

| Style Specification | Year-Month Interval | Day-Time Interval | Mixed Interval |
| -------- | -------- | -------- | -------- | -------- | 
|sql_standard | 1-2 | 3 4:05:06	| -1-2 +3 -4:05:06|
|postgres |	1 year 2 mons | 3 days 04:05:06	| -1 year -2 mons +3 days -04:05:06|
|postgres_verbose | @ 1 year 2 mons	| @ 3 days 4 hours 5 mins 6 secs	| @ 1 year 2 mons -3 days 4 hours 5 mins 6 secs ago|
|iso_8601 | P1Y2M | P3DT4H5M6S	| P-1Y-2M3DT-4H-5M-6S|


## Boolean

Стандартный SQL тип *boolean*.
Несколько состояний: "true", "false", "unknown" (null).
Размер - 1 байт.


Допустимые значения для TRUE (case-insensitive): 't', 'true', 'y', 'yes', 'on', '1'.
Для FALSE: 'f', 'false', 'n', 'no', 'off', '0'.

Leading or trailing whitespaces are ignored.
Ключевые слова TRUE/FALSE  are SQL-compliant.

## Enumerated

Статический, упорядоченный набор значений.
Типа похож на enum в разных языках программирования.

## Declaration

```
CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy'); -- создание типа, перечисление значений задает их порядок для сравнения (чтобы поддерживались сортировка и разные ф-и.
CREATE TABLE person ( -- используется как обычный тип.
    name text,
    current_mood mood
);
```

### Безопасность типа

Нельзя вставить значение, которое не перечислено в типе.
Нельзя сравнивать поля разных типов.
```
INSERT INTO holidays(num_weeks,happiness) VALUES (2, 'sad');
ERROR:  invalid input value for enum happiness: "sad"
SELECT person.name, holidays.num_weeks FROM person, holidays
  WHERE person.current_mood = holidays.happiness;
ERROR:  operator does not exist: mood = happiness

-- Но, можно откастить и сравнить:
SELECT person.name, holidays.num_weeks FROM person, holidays
  WHERE person.current_mood::text = holidays.happiness::text;
```

### Детали реализации

Enum значения занимают 4 байта на диске. Длина имени значения - ограничена NAMEDATALEN (63 bytes by default + terminator).

**Enum labels are case sensitive и whitespaces тоже учитываются.**

Перевод из внутренних значений enum в текстовые метки хранится в системном каталоге pg_enum. М.б. полезно работать с этим каталогом.

## Geometric types

Двумерные объекты.
Есть также много функций для всяческих трансформаций и определения пересечений.

### point

16 байт, два floating-point числа.

* Input/output: (x, y)
* input only: x, y

### line

Ax + By + C = 0 (Бесконечная прямая) (нельзя, чтобы A and B были нулями одновременно).

32 байта.

* input/output: {A, B, C}
* input: 
	* [ ( x1 , y1 ) , ( x2 , y2 ) ]
	* ( ( x1 , y1 ) , ( x2 , y2 ) )
	* ( x1 , y1 ) , ( x2 , y2 )
	* x1 , y1   ,   x2 , y2

### lseg

32 байта.

* input/output: [ ( x1 , y1 ) , ( x2 , y2 ) ]
* input only: 
	* ( ( x1 , y1 ) , ( x2 , y2 ) )
	* ( x1 , y1 ) , ( x2 , y2 )
	* x1 , y1   ,   x2 , y2

### box

32 байта.
Любые два противоположных угла.

* input/output: ( x1 , y1 ) , ( x2 , y2 )
* input only:
	* ( ( x1 , y1 ) , ( x2 , y2 ) )
	*  x1 , y1   ,   x2 , y2


### path

Список соединенных точек.
16 + 16n bytes.

В квадратных скобках - разомкнутый, в круглых - замкнутый.
Если вообще нет самых внешних скобок - замкнутый.

* input/output
	* [ ( x1 , y1 ) , ... , ( xn , yn ) ] -- open
	* ( ( x1 , y1 ) , ... , ( xn , yn ) ) -- closed
* input only:
	* ( x1 , y1 ) , ... , ( xn , yn )
	* ( x1 , y1   , ... ,   xn , yn )
	* x1 , y1   , ... ,   xn , yn

### polygon
40 + 16n bytes
Список вершин полигона. Хранится в отличном от path формате, и имеет свои функции.

 * input/output: ( ( x1 , y1 ) , ... , ( xn , yn ) )
 * input:
	* ( x1 , y1 ) , ... , ( xn , yn )
	* ( x1 , y1   , ... ,   xn , yn )
	* x1 , y1   , ... ,   xn , yn

### circle
24 bytes

 * io < ( x , y ) , r >
 * i: 
	 * ( ( x , y ) , r ) 
	 * ( x , y ) , r
	 * x , y   , r

## Network Address types

Лучше юзать эти типы, т.к. есть проверка корректности и разные ф-и.
При сортировке inet и cidr, IPv4 идут перед IPv6, даже встроенные и отмапленные на IPv6.

### inet (7 or 19 bytes)

Адрес + subnet (кол-во бит на host address, netmask). Если netmask - 32 для IPv4, значение определяет только хост, без подсети.
В IPv6 длина адреса 128 бит, они задают уникальный адрес хоста. Если нужно хранить только сети, лучше юзать *cidr*.

Входной формат: adress/y, adress - IPv4 or IPv6 адрес и y - количество битов в маске. Если /y - нет, то маска - 32 бита для IPv4 и 128бит для IPv6,
так что значение задает одиночный хост.

При выводе /y часть не показывается, если её нет.

### cidr (7 or 19 bytes)

IPv4 / IPv6 сеть. Classless Internet Domain Routing.
В отличие от inet - не принимает значения с ненулевыми битами после маски.
adress/y. Если /y нет - используется old classful network numbering system, кроме случаев, когда хватает места для включения всех октетов из инпута.
(??)

Есть функции host, text, abbrev.(??)

### macaddr (6 bytes)

* '08:00:2b:01:02:03' -- output/input, (bit-reversed notation in IEEE (01:00:4D:08:04:0C), but PG do not support it)
* '08-00-2b-01-02-03' -- canonical form (LSB order)
* '08002b:010203'
* '08002b-010203'
* '0800.2b01.0203'

## Bit string

Строки из 1 и 0. Могут юзаться для визуализации битовых масок.

* bit(n) // error at storing longer or shorter strings, default: bit == bit(1). При явном касте - truncation или zero padding to n bits, w/o errors.
* bit varying(n) // longer strings are rejected. bit varying - unlimited length. При явном касте большей длины - truncation.

Есть разные функции и операции для логических операций:
http://www.postgresql.org/docs/9.4/interactive/functions-bitstring.html

```sql
CREATE TABLE test (a BIT(3), b BIT VARYING(5));
INSERT INTO test VALUES (B'101', B'00');
```

## Text Search Types

Full text search. Поиск по коллекции документов на нативном языке.




================