http://patshaughnessy.net/2014/11/11/discovering-the-computer-science-behind-postgres-indexes

Автор лазил в сорцы pg и смотрел как работает индекс для строкового значения.

Последовтельный поиск.
Проходит тупо все записи.

Значения становятся ключами для B-Tree.

Допустим, в таблице были имена и фамилии.
В индексе они становятся *ключами*.

* IndexTupleData
* bitmap
* value

Что такое index attributes??
Возможно, это значения в столбцах (столбцов может быть много, т.к. индекс может быть мультистолбцовый).



IndexTupleData -> t_tid + t_info

* t_tid - указатель либо на другой index tuple, либо на запись в бд.
Это не указатель, это некий внутренний индекс PG.

* t_info - инфо как много значений, и есть ли NULLs.


?? Якобы PG дублирует parent key в каждом child node.

---

Для текста тоже есть операторы сравнения.


=========

При вставке ключ вставляется в дерево в нужное место согласно сортировке.
Если надо - node расщепляется, тогда ссылка и ключ добавляются в парент.
Если надо - parent тоже расщепляется, в общем, рекурсивная операция.

(Я все ещё не понимаю зачем дублирование)? 

====

При удалении ключа ПГ попытается скомбинировать сиблингов, удаляя ключ из родителя.
Тоже может быть рекурсивно.

====

Дочерние узлы имеют указательи на правого сиблинга. Якобы это позволяет не лочить весь индекс.





