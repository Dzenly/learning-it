https://www.youtube.com/watch?v=Q1kquRGtrKE

# CAP теорема (Теорема Брюера)

Consistency (согласованность)
Availability (доступность)
Partition Tolerance (устойчивость к разделению)

Можно только два из трех свойств выбрать.

=======

https://www.youtube.com/watch?v=qQuLPr8J7aQ

Распределенная система, - это где отказ какого-то компа, про который вы
не знали влияет на вашу работу.

AP - DNS

=======

# ACID

https://www.youtube.com/watch?v=vFmajCQ7Wuc

* Atomicity (транзакция либо вся выполняется, либо вся не выполняется)
* Consistency
* Isolation (нельзя изменять данные в которые идёт предыдущая запись, параллельные транзакции не влияют друг на друга)
* Durability (стойкость, если транзакция завершена, значит оно сохранено)

=======

# BASE

https://habr.com/ru/post/328792/

* Basic Availability (Доступность, но ответ может содержать ошибку или несогласованность)
* Soft-state (состояние меняется со временем, из-за изменения конечной согласованности)
* Eventual consistency (в конечном счете станет согласованной)

=======

# RAFT

https://habr.com/ru/company/dododev/blog/469999/

Алгоритм распределенного консенсуса.
Консенсус сети ненадежных вычислений.

Лидер реплицирует.

Кандидаты, голосование, сроки.

Если фолловер не получает сообщений от лидера, он инициирует выбор
нового лидера.
Инкрементит номер срока, голосует сам за себя, и рассылает RequestVote.
Первый достучавшийся кандидат - получает голос.
Новый выбранный лидер - шлет всем кандидатам отбой.

=========

# Serf

=========

# Gossip

=========

Blue / Green
https://www.youtube.com/watch?v=giEJOVmv0ug

A / B тесты


=======

SOLID

GRASP (9 принципов)
