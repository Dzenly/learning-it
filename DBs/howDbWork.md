
Толковая обзорная статья.

http://habrahabr.ru/company/mailru/blog/266811/

Поиск элемента в хорошей хэш-таблице занимает О(1).
В хорошо сбалансированном дереве — O(log(n)).
В массиве — O(n).
Наилучшие алгоритмы сортировки имеют сложность O(n*log(n)).
Плохие алгоритмы сортировки — O(n2).

Во многих СУБД сортировка по-умолчанию выполняется слиянием.

=========

Статистику нужно регулярно обновлять.
Похоже, не все базы занимаеются этим сами.

При проектировке данных фамилия имя лучше чем имя фамилия. Из-за того, что фамилии встречаются реже сравнение строк займет меньшее время.

Если наводишь статистику по кусочку таблицы, есть риск, что экстраполяция ухудшит производительность.


CBO оценивает:

* CPU
* Memory
* I/O operations.


==

Некоторые БД могут динамически создавать индексы для текущих запросов.

Для эффективного сканирования диапазона нужно иметь индекс.


Если строка из таблицы не нужна, и нужно только значение столбца, который проиндексирован, то IO к таблице не будет.

Индексы эффективны только если выгребается мало строк, иначе большие расходы на IO.

===

При объединении внутренняя зависимость должна умещаться в памяти, тогда обращений к IO будет мало.

Также хорошо использовать индекс в качестве внутренней зависимости.

Если внутренняя зависимость не влезает в память, можно попробовать сэкономить на IO, считывая группы строк.

==

Хэш объединение, стоимость ниже, чем объединение вложенными циклами.


====

Мало памяти - не получится эффективно использовать хэш объединения.

Если одна из таблиц маленькая - объеденинеие с помощью вложенных циклов будет эффективно.
Если обе большие - ресурсы процессора сожрутся.

Процедура создание хэшей дорогая.


Слияние рулит, если:

* Есть два B-Tree индекса.
* Выходные зависимости отсортированы
* Нужно отсортировать результат (используются ORDER BY/ GROUP BY/ DISTINCT)

В некоторых типах JOIN некоторые способы объединения не работают.

Распределение данных и возможности делать хороший хэш влияют на действенность хэш методов.


===

Т.к. время на принятие решений ограничено, планировщик использует "хороший план", а не "лучший план".


===

Есть кэш планов запросов.
Кэш обновляется, когда есть существевнные изменения в статистике.

=============

ACID

* Atomicity. Транзакции либо выполняются либо нет, нет наполовину выполненной транзакции.
* Consistency. Соглассованность связей.
* Isolation. Одновременные транзакции не влияют друг на друга.
* Durablity. Если транзакция успешно завершилась. То даже если в БД будет крэш через милисекунду, изменения в БД от этой транзакции сохранятся.

=====

## 4 уровня изоляции транзакций:

* Serializable - высший уровень изолированности.
* Repeatable Read (оно же - фантомное чтение??). Параллельное добавление новых данных видно выполняющимся транзакциям.
?? Получается в одной транзакции один запрос может давать разные результаты. Что с удалямыми данными?
* Read commited. Используется по умолчанию в PG, Oracle, MS SQL. Параллельная транзакция видит добавления/удаления/изменения.
* Read uncommited. (dirty read). Видны даже незакоммиченные изменения.

* Изоляция на основе снэпшотов (PG, Oracle, MS SQL).

После установления соединения можно изменить уровень изолированности.


Можно тупо лочить данные.
Можно по принципу SWMR.

Есть вероятность дедлоков, при этом транзакция может откатиться.


Сложно отслеживать циклические зависимости. Часто отслеживают таймаут блокировки.


Некоторые БД вводят в транзакции две фазы: когда разрешены блокировки, и когда нет.


=====

## Версионность данных:

Каждая транзакция работает со своей версией "общих" данных.
Если две транзакции меняют одни данные - одна модицикация будет принята, другая откачена.


PG использует комбинацию блокировок и версионности.

==========

# Надежность транзакций

* Теневые копии (для транзакции создается копия куска БД). Если ОК - БД переключится на эту копию.
Нужно очень много места на диске.

* Лог транзакции. Специальное, защищенное от сбоев, хранилище. В случае сбоя есть инфа как завершить или удалить незавершенную транзакцию.
Используется чаще.

==

## WAL (Write Ahead Logging protocol)

Несовершенные правила WAL.

* Каждая модицикация БД логируется до того, как идет запись на диск.
* Очередность в логе должна соответствовать очередности модификаций.
* Запись о коммите транзакции заносится в лог до момента успешного завершения транзакции.

### ARIES

Algorithms for Recovery and Isolation Exloiting Semantics. Отвечают за хорошую производительность при записи логов и за быстрое и надежное восстаовление.

Лог состоит из записей изменений. Одна транзакция может давать много записей в лог.


Каждая страница на диске содержит номер записи последней операции модификации.


=========

* NO-FORCE - На диск можно писать после коммита.
* FORCE - на диск пишется до коммита.
* STEAL - пошаговая запись данных на диск
* NO-STEAL - запись одним чохом.



















