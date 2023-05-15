? как кладёт коммиты git merge (RVN-1 в 4.1-test).

https://www.youtube.com/watch?v=Du7Ay5o-Png

git rebase master - перебазировать текущую ветку на master.

git rebase --abort // возвращает HEAD

git rebase --quit // не возвращает HEAD

Есть понятие пустых коммитов (когда аналогичная правка уже есть в базовой ветке).

git rebase что куда

https://www.youtube.com/watch?v=n3wUskqbPzM

git merge master // в текущую ветку.

===

# Проблемы с git rebase:

* *Если над веткой работают больше 1 человека, то переписывание истории, включая rebase, запрещены!*

* Коммиты на самом деле не те, что делал автор, а автоматические. И там могут быть семантические конфликты.

Даже если мы правим ошибку, внесением дополнительного коммита.
То есть риск откатиться на сломанный комит.
В общем, вероятность, попасть на ошибку, при откате на какой-то коммит - повышается.

===

**git rebase -x
можно запускать тесты после каждого перебазированного коммита.**

=============

Если коммиты сделаны не на той ветке по ошибке, их можно перенести на нужную.



===============

https://www.youtube.com/watch?v=5_hwps7u-ts&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h&index=27

===============

https://www.youtube.com/watch?v=n3wUskqbPzM




===============

https://www.youtube.com/watch?v=8Mpj5v6vUiw&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h&index=53

git merge --no-ff


*git config merge.ff false*

===============

https://www.youtube.com/watch?v=IQTlWxyn6Cc&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h&index=62


git rebase --onto master feature

===============