http://www.youtube.com/watch?v=0zSBe5Ph3qU&index=22&list=PLqOMfjuJszgSRw1-Sp1KAbUStv5wlk8Cs

2013 год.

Данные первичны - База данных вторична.

# Neo4j - графовая бд.

Оптимальная для сильно связанных сущностей.
Вершины, ребра, аттрибуты.
Индексы для значения аттрибутов.
ACID
REST API + Cypher
Множество плагинов.

Нет полноценного горизонтального масштабирования.


Якобы большие данные не совместимы с SQL.

NoSQL - узкоспециализированные БД.

NoSQL - Нет нормальных транзакций, как правило.

//CAP теорема: 

Если данные дорогие и очень нужные - NOSQL не стоит юзать.


NoSQL разработчиков меньше половины от всех БД разрабов.

Федерация БД. Связи между разными БД, чтобы работать в SQL парадигме.


NoSQL требует очень грамотных и дорогих программистов.

NoSQL сильно связана с архитектурой проекта, соответственно ошибки значительно дороже.


Скип индексы.


User Defined Types (Oracle feature)

FlashBack. Можно отказываться на какие-то моменты в прошлом.

Репликация - есть одна копия на запись и дофига на чтение.

В распределенных системах можно разделять географически.

Вертикальное масштабирование - работа на мощном оборудовании.

Горизонтальное масштабирование - много слабых серверов.

# CAP теорема

http://habrahabr.ru/post/130577/

Consistency (в распределенном смысле), Availability, Partition Tolerance.

=====


https://ru.wikipedia.org/wiki/%D0%A2%D0%B5%D0%BE%D1%80%D0%B5%D0%BC%D0%B0_CAP
BASE - архитектура.

Basically Available, Soft-state (неустойчивое состояние), Eventualy consistent (weak consistent)

http://habrahabr.ru/post/231703/

С математической точки зрения это не совсем теорема.
Хотя есть попытки формализовать и доказать.

Delayed Consistency.

===

Eventualy consisted не выполняется при частой записи.

На CAP диаграмме некоторые базы позволяют выбирать в процентах насколько A, насколько C.

NewSQL.

http://www.youtube.com/watch?v=SWkcPQ96mi4&index=19&list=PLqOMfjuJszgSRw1-Sp1KAbUStv5wlk8Cs









