https://www.youtube.com/watch?v=nKZsA4T7QPg&feature=youtu.be&ab_channel=%D0%A4%D1%80%D0%BE%D0%BD%D1%82%D0%B5%D0%BD%D0%B4

Сборщик мусора умеет считать дифы, и оптимизировать хранение.

Состояния файла:

* Рабочая директория.
* Индекс.
* Репа.

git rebase --skip - пропустить патч.


У коммитов есть автор, а есть комиттер. Например, тот, кто ребейзит.


HEAD~ - на сколько назад.

HEAD^ - родитель ?

HEAD = @

HEAD~ = HEAD~1

git rev-parse HEAD

git revert - creates new commit with cancelled changes.

If I merge feature in master - first parent is master.

git revert -m 1 - cancel feature changes.

По умолчанию git reset --mixed, положить измененные файлы в рабочую директорию.

--soft - изменения в index.

reset - не удаляет коммиты, он просто двигает ветку на коммит.

--hard опасен только тем, что удаляет изменения из рабочей папки.

====

Если я не хочу ревертить, но хочу изменить историю ветки.
git rebase -i

Stash - фейковая ветка.

git clean -n - dry run.

git clean -f - force.

git show - посмотреть что за коммит.

git commit --amend оставляет дату прежней.

==================

git remove -v

default remote (upstream) is "origin"

origin/master - локальное состояние удаленной ветки.

git merge - делает ff.

В ветке master - только коммиты слияния (в github flow).

git log сортируется по дате.

git log --one-line --graph

Коммит мессага:

Тип изменения: Номер ветки: Описание.

**1й родитель то, куда мержили.**

Может быть больше 2х родителей.













