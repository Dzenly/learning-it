# http://stackoverflow.com/questions/31472427/unable-to-understand-sql-explain-plan

* Cardinality - Подсчет кол-ва строк для каждой операции.
* Access method - Index/Table scan.
* Join Method
* Join Order

NESTED LOOPS

SORT MERGE JOINS



# http://stackoverflow.com/questions/860450/understanding-the-results-of-execute-explain-plan-in-oracle-sql-developer?lq=1

CBO - Cost based optimizer.

CBO не всегда имеет время пересмотреть все возможные планы, и выбирает лучший из уже рассмотренных.

Если надо считывать много блоков - это тормозит.

FULL SCAN может быть быстрее, чем через индекс и потом обращение к таблице.

---

Есть CPU_cost, есть I/O_cost.

Cost дает понятие ПОЧЕМУ optimizer делает что-то.

Статистика очень важна для работы CBO.


-----

Якобы, в новом Oracle, Cost отражает оценочное ВРЕМЯ для запроса, где 1 это время, нужное для считывания одного блока.

Для оценки CPU_Cost - в Oracle используется System statistics:

* Single block read time
* Multiblock read time ??
* ?? How large a multiblock read is ??
* CPU performance

Могут быть поправки на время суток.










==========



