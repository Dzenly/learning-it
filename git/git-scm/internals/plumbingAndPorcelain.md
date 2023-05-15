https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain

Git это как бы файловая система.

.git

Структура директорий:

* config - project specific configs.
* info - global exclude

* objects - DB with all content.
* refs - pointers into commit objects (branches),
* HEAD - pointer to currently checked out branch.
* index - staging area information.

https://git-scm.com/book/en/v2/Git-Internals-Git-Objects

Core of Git is key-value data store.

Низкоуровневая команда - **hash-object** -w - сохраняет некий текст
в .git/objects/<2 first letters from SHA-1>/<38 last letters from SHA-1>
и возвращает ключ.

**cat-file** - выдает контент, или размер, или тип.

Content is BLOB.

**cat-file** -t

tree объекты позволяют хранить группу файлов вместе,
 содержат один и более tree entries, each of which contains a SHA-1 pointer to a blob or subtree.
 
**git cat-file -p master^{tree}** - tree объект для последнего коммита в master.

**git cat-file** позволяет лазить по директориям, по хэшам.

**update-index** 

Создать запись в индексе (stage area).

git update-index --add --cacheinfo 100644 83baae61804e65cc73a7201a7252750c76066a30 test.txt

Для блобов (для директорий другие modes) валидны следующие modes:

* 100644 - normal file.
* 100755 - executable file.
* 120000 - symbolic link.

**git write-tree** command to write the staging area out to a tree object.

**read-tree** - читает инфу о tree в index.

**checkout-index** index -> working tree.








