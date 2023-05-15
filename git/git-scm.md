https://git-scm.com/book/en/v2/Getting-Started-Git-Basics


При каждом коммите или сохранении состояния проекта,
гит сохраняте состояние всех файлов (с внутренней оптимизацией, например линки на неизмененные файлы).

Почти все операции в гите - локальные.

Есть фраза про local difference calculation, видимо, дифы генерятся на лету?

Все изменения и повреждения детектятся через чексуммы.

Почти все действия только добавляют данные в базу гит.
Т.е. трудно сделать что-то неотменяемое.

Гит имеет три состояния файлов:

* commited - сохранен в локальной базе. / git directory (копируется при клонировании)

* modified - есть изменения, но в базе не сохранены. / working directory

* staged - маркирован, чтобы попасть в базу при следующем коммите. / staging area

Working directory - вытаскивается из сжатой базы.

Staging area - файл обычно хранимый в Git Directory, с тем, что пойдет в следующий коммит. Оно же - **Index**.

Commit - перемещает файлы из Staging Area в Git Directory.

==================

# 2.x

git init - перед треканьем существующего проекта.
Дальше git add, git commit.

git clone - скачивает почти все с сервера (кроме хуков и тому подобного) (все версии всех файлов).

Если что-то повредилось на сервере, можно восстановить файлы (кроме хуков).

## 2.2

Tracked files - существуют в последнем snapshot (бывают unmodified, modified, staged).

Untracked - все остальное. 

git status - в каком состоянии какой файл, untracked - тоже должны показываться.
Расходится ли локальная копия ветки с веткой на origin.

git add - чтобы начать трекать файл.

Staged в git status - Changes to be committed.

Not staged for commit - modified.

git add - пометить конфликт как разрезолвенный.

git add - добавить что-то в следующий коммит.


Если есть модификация файла, сделанная после git add - она не попадет в следующий коммит.

*git status -s* - укороченный вывод.
Две колонки - левая отвечает за staged, правая за non staged.

git diff - work dir vs staging area.
git diff --staged - staged vs last commit
git diff --cached - synonym to --staged.


git commit -a - автоматический git add для всех tracked files.

git rm - перестать трекать файл и удалить.
git rm -f - удалить даже staged.

git rm --cached file - отмена git add.

git mv - переместить или переименовать.

==================

### Viewing the Commit History

git log

По умолчанию - последний коммит показывается выше всех.

git log -p -2 - показывать дифы внесенные в коммитах, по 2 штуки.

git log --stat
Статистика по коммитам.

git log --pretty=oneline

git log --pretty=format:"%h - %an, %ar : %s"

Author - тот, кто написал изменение.
Commiter - тот, кто приапплаил патч, присланный автором.

git log --pretty=format:"%h %s" --graph

--since 2.weeks
--before
--author
--committer
*--grep* - по строкам в комментариях.
*-S*  - по строкам в коде.

===================================

### Undoing Things

Осторожно, т.к. тут есть опасность потерять данные.

git commit --amend

Staging area is used for the commit.

Если нет изменений с последнего коммита - то изменится только коммент.

Если есть изменения - то они перетрут последний коммит.

*но, вроде бы, есть возможность все вернуть*, т.е. **то,что закоммичено не теряется**.

**То, что не закоммичено - теряется**

### Unstaging a staged file.

git status - подсказывает как undo staging. (use git reset HEAD file)

git reset --hard - опасна.
без этой опции git reset безопасна, она только затрагивает staging area.

### Unmodifying

git checkout -- file

опасная команда.
Если изменения нужны - можно юзать stashing and branching.

===============

## Working with Remotes.


















https://git-scm.com/book/ru/v1/%D0%92%D0%B5%D1%82%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-Git-%D0%A7%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-%D0%B2%D0%B5%D1%82%D0%BA%D0%B0%3F

Гит хранит данные как последовательность снимков состояния.

При коммите в базу записывается объект-коммит,
который содержит указатель на снимок состояния (записанный ранее в индекс).









