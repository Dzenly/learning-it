https://git-scm.com/docs/git-revert

Working tree should be clean.

reverts some commit.

Отменяет изменения

==========

Был коммит1, сделали коммит2, затем коммит3.

Сделали revert коммит2.
Т.е. из коммит3 убрали патч между коммит2 и коммит1 ?

=====

Был коммит1, сделали две ветки, в одной коммит 2,
в другой коммит 3.

влили ветку2 (коммит4), влили ветку3 (коммит5).

Итого, коммит4 - это патч на коммит 1.
патч из дифа коммит2 и коммит1.
У этого коммит4 - два родителя: ветка1 и ветка2.
По идее, это теперь общий предок для ветки1 и ветки2.


затем на коммит4 накатили патч, связанный с веткой3.


=====================

https://github.com/git/git/blob/master/Documentation/howto/revert-a-faulty-merge.txt

После повторного мержа код, который был до ревернутого мержа не попадает в бранч.
(типа гит думает, что мерж уже был)

---

Типа надо отревертить предыдущий реверт.


