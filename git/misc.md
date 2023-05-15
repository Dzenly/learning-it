https://www.youtube.com/watch?v=C6lGTQAvE24&index=5&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h

linux prompt.

autocompletion.

===========

# Конфигурация.

git config user.name ""
git config .


 HEAD - ссыль на текущую ветку.

 git checkout -f HEAD - отмена изменений.
 git checkout -f -то же самое, т.к. HEAD - по умолчанию.

 Можно git stash pop применять на ветке отличной от git stash.
 Но могут быть конфликты.

 Но вообще прикольный способ переноса изменений если начал не с той ветки.


checkout ругается если изменяется файл, который различается между ветками.

==========

Перенос веток.

git branch -f master 54a4

==========

git удаляет со временем недостижимые коммиты. (detached HEAD)

cherry-pick - можно забрать коммиты из неправильного места в правильное.

==========

Можно взять файл по состоянию на такой то коммит или такую-то ветку.

git checkout 54a4 index.html.
если есть файл 54a4 - /

==========

двойной дефис - позволяет указать, что нам нужен файл а не ссылка.

git checkout -- master.

==========

git show HEAD~ - на родитель.
кол-во тильд.
HEAD~15

HEAD - @

==========

Показать какой файл был раньше.

git show @~:index.html

git show bybranch:mypath

git show :myptatp - что в индексе.

==========

git show :/чтоискатьвописаниикоммита.


==========

ORIG_HEAD
head до операции.

git branch -f master ORIG_HEAD

==========

git checkout -B master fix - перенос, даже если стоишь на этой ветке.

==========

git branch -d fix - удаляет ветку.

Если ветка не влита - будет ошибка.

Если нет ссылок на коммиты - гит их со временем удалит.

==========

git reflog ref

Причем есть даже инфа о переключении веток, когда коммитов нет.
В общем походу ведется история.

Удаление веток не меняет head, по поэтому не пишется в reflog.


Можно юзать записи из рефлога как ссылки.

git branch feature HEAD@{6}

https://www.youtube.com/watch?v=4tgMJ6ZA_zQ&index=29&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h
git reflog --date=iso
Соответственно, можно обращаться по дате.
Причем если такой даты нет, то возьмется более старая максимально приближенная.

==========

По умолчанию рефлоги хранят данные за 90 дней для достижимых коммитов.
И 30 дней для недостижимых.

==========

git checkout @{-1} - вернуться на ветку, откуда мы чекаутнулись сюда.
То же что git checkout -

==========

Сборка мусора.
Проходятся все паренты.

git gc

gc.pruneExpire - 2 недели.

Пока жив коммит, живы и родители.

git filter-branch - можно удалить секретные коммиты.

но BFG проще.

git reflog expire --expire=now -all

==========

git tag v1.0.0
git show v1.0.0

Теги не перемещаются.

git tag - список тегов.

Есть  легкие теги, есть теги с аннотацией.

git describe - по коммиту.
ближайший тег.

==========

ORIG_HEAD не влияет на сборку мусора.


git reset --hard - меняет рабочую директорию.

git reset --soft - не меняется.

git commit -C ORIG_HEAD - взять описание из ссылки.

git commit --amend = git reset --soft @~ && git commit -C ORIG_HEAD

==========

 Смешанный ресет - по умолчанию.

 Сбрасывает индекс, но не трогает раб. директорию.

 ==========

git help log
можно вручную задавать формат информации о коммите.

git help config - инфа по цветам.

git config --global format.pretty my

git log feature ^master
фича минус мастер.
оно же `git log master..feature`
только то что в фиче без мастер.

`git log feature..master`
что в мастере есть такого, что нет в фиче.

Т.е. две точки, это когда от общего коммита смотрим только
для ветки, указанной второй.

HEAD можно не писать.

==========

`git log master...feature`
разность веток.
показыаются изменения в обеих веток после общего коммита.

`--boundary` - общий коммит.

git help revisions

===========

git diff имеет другой смысл двух и трех точек.

==========

`git log index.html` -
commits where index.html was changed.

-p - посмотреть различия.
--follow - отслеживать ренеймы.

`git log feature..master -- dir1 dir2`

==========

`git log --grep Run <ref>`

Search for commits with 'Run' in description.

--all-match - AND

Фридл Регулярные выражения.

==========

`git log -GsayHi -p`

Поискать в изменениях строку.

`git log -L 3,6:index.html`
коммиты где менялись строки 3 - 6.
Вместо номеров строк можно регэкспы начала и конца фрагмента.

--before
--after
--author
--commiter

==========

git blame <filePath> --date=short -L 5,8

git

==========

**git merge-base master feature**

ours - current.
theirs - what me merge to current.

==========

MERGE_HEAD - коммит, с которым сливаемся.

Есть состояне - `прерванный мерж`

git diff -U<n>

git reset --merge === git merge --abort

`git checkout --conflict=diff3 --merge mypath`
покажет и базовый кусок.

`git show :1:mypath` - общая.
`git show :2:mypath` - наша
`git show :3:mypath` - их

git commit === git merge --continue


Коммит слияния - два родителя.

git show покажет родителей.

диф для мержа тоже особый.

`git show --first-parent`

Дифы с родителями:
`git diff HEAD^1`
`git diff HEAD^2`

Можно и дифы с дедушками HEAD^^
Или вообще HEAD^2^2

**here**
`git branch --merged` - ветки, объединенные с текущей.
`git branch --no-merged` - не объединенные.

**git merge feature --log** - добавить в мессагу слияния все мессаги коммитов.
По умолчанию - не более 20.

При исследовании очень полезно знать что за мерж.
Если коммиты были грамотные.


git log master --oneline

git log master --oneline --first-parent
если мержил фичи в мастер - то будут только коммиты в master.

А у нас как бы мастер подливается.
Хорошо , что мы везде префиксы номеров задач указываем.

==========

**Для тестирования можно поизвращаться с отменой коммита**

git reset --hard @~

==========

https://www.youtube.com/watch?v=BQmrsXj8SwA&index=52&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h

**Семантические конфликты**


`git merge feature --no-commit`
чтобы разрулить семантические конфликты.

**Вот поэтому хорошо бы делать**
`git merge feature --no-commit`,
дальше натравливать eslint / tslint, flow, etc.
И если нет семантических косяков - то ок.

==========

--no-ff

Если fast forward, то трудно откатить

git config merge.ff false

git config branch.master.mergeoptions '--no-ff'

??
При каком сценарии мы можем удалить ветку
и откуда мы её удалим.
Колбасим фичу.

Допустим, хотим выпилить ветку RVN-xxxx из 4.1.

Раньше можно было бы выкинуть коммит слияния.

?? Как выкинуть коммит ??

А теперь придется выкинуть кучу коммитов,
у которых в сообщении есть такой то префикс.


git check-ignore -v path

.git/info/exclude - мои личные файлы.

XDG_CONFIG_HOME

~/.config/git/ignore

Working Directory /  Index / Repository

# комменты игнорятся в коммит мессагах.

Первая строка из редактора идет как title коммита.

100664
100 - файл.
664/755 - права. Гит волнуют только эти два варианта.

Изменение прав гитом отслеживается.

Под windows - по умолчанию 644.
Но можно командами гита ставить флаг.

git show - инфа о коммите. --pretty=fuller.


Автор и коммитер - могут быть разными людьми.


git commit --author.

git status не идет внутрь неизвестных директорий.

git add . - добавить всё.

git reset HEAD .idea

Игнорировать игнор.
git add -f .idea/project.iml.

*Важно структурировать коммиты*.
Коммиты должны быть атомарны.
Хорошо бы каждый коммит быть завершенным.
И хорошо анализировать большие изменения покоммитово.

* М.б. у и нас ввести префикс в коммите.
feat, test, fix.


git commit -m "msg" path1, path2.

git rm -r src
git rm --cached - не удалять из раб. директории.

git mv


=============================

Схема работы с релизными ветками.
Готовим ветку к релизу.
Если баги - то фиксим их в master и черрипикаем в релиз.


===========================


**git merge --squash fix**

Как обычный коммит, с одним родителем.
fix потом можно удалить.

Если надо отменить merge, то
git merge --abord не сработает.
Но git reset --merge работает.

Состояние конфликта - это особое состояние индекса.
В котором присутствуют три состояния.
Базовое - и два сливаемых.

(поди и больше 3х может быть)

Конфликты могут возникнуть и при git stash pop.

==========

Драйверы слияния.

У бинарных файлов тоже есть конфликты.
Тогда git будет ждать, что мы заменим текущую версию
на правильную.

Есть драйвер слияния - union.
В нем сохраняются.

**М.б. для package-lock брать какую-то стратегию, типа theirs ?**

.gitattributes
/NEWS.md merge=union
Побочный эффект - удаленные строки остаются.

**Можно попробовать чиркануть свой драйвер слияния для
localization.json**
Если ключи просто добавляются - то
считать оба файла, смержить их и записать снова.

И только если добавлены одинаковые ключи с разными значениями,
или в одной ветке ключ удален, а в другой - изменен.
Тогда уже ругаться.

**В любом случае, надо последить за localization.json**
**И за package.json во всех папках.**

==========

https://www.youtube.com/watch?v=rekRTomD2sI&index=56&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h

Стратегии слияния.

recursive - стратегия по умолчанию.

*Виртуальный родитель.*

no-renames.

Бывают конфликты переименований.

При переименовании - гит ищет файл,
который отличается от исходного не более, чем на 50%.
С мелкими файлами это может работать некорректно.

-Xno-renames

-Xfind-renames=80 - поднять порог с 50 до 80%.

==========

cherri-pick можно заменить обычным бранчеванием.

==========

rebase

info is written to reflog.

Классная штука, чтобы не портить историю.
Вместо того, чтобы мержить в себя master,
можно делать rebase.

Нельзя ребейсить если над веткой работают больше 1 человека.

Ещё у ребейза есть недостатки,
что это не оригинальные коммиты, и они могут
иметь семантические конфликты.

И ещё на один из таких коммитов откатываться опасно.

Получается, если делать rebase, то обязаны быть
хорошие автотесты.

git rebase -x 'utility to execute'
например, автотесты.

==========

git rebase --onto <where> <from>

==========

https://www.youtube.com/watch?v=cuk3LQAG2PE&list=PLDyvV36pndZHkDRik6kKF6gSb0N0W995h&index=66

rerere

Если делал ветку,
затем ребейсишь.

Reuse Recorded Resolution.

**git config rerere.autoUpdate true**

git checkout --merge index.html

git rerere forget index.html


.git/rr-cache

rerere.rerereResolved
rerere.rerereUnresolved

git config rerere.enabled true/false

Если unset - то надо удалить кэш.

rerere-train.sh --all

==========

git revert - инвертирует изменения.

git revert A..B

Реверт мержа.

git revert <commit> -m <номер родителя>

==========

Реверт мержа общим родителем оставляет коммит
ветки.
Типа старые коммиты ветки уже есть.

git revert и коммит, который сделан при реверте.

==========

git rebase <commit> --no-ff
перебазировать но туда же.

==========

Гит понимает и дату в ms from epoch.

==========

==========
==========
==========
==========
==========
==========
==========
==========


























