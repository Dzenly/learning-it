https://golang.org/doc/code.html

*Package* - collection of sources in the same directory which are compiled
together.

Funcs, types, vars, consts defined in one source are visialbe to all other
sources within the same package.

*Module* - collection of related Go packages that are released together.




Похоже, все проекты Go принято хранить в одном *workspace*.

workspace содержит *repositories*.

each repository contains one or more *packages*.

each **package** consists of one or more Go source files in a **single directory**.

$workspace:

* src - Go source files
* pkg - package objects
* bin - executable commands.

Дефолтный workspace dir is $HOME/go/

export PATH=$PATH:$(go env GOPATH)/bin

======

# Import path

Строка, идентифицируются *пакет*.
Соответствует положению в воркспейсе или в remote repository.

Пакеты из стандартной либы имеют короткие пути: fmt, net/http.

Базовый путь к пакетам должен быть уникальным, например: github.com/user.
Появляется требование - код в репозитории должен быть рабочим.

Из-за воркспейса в путях, не нужно быть в текущей директории, чтобы юзать go cmd line.

go install - устанавливает бинарник в $workspace/bin и зависимости в ./pkg.

Типа cmd line тулзы пишут что-то в stdout/stderr, только если какие-то ошибки.

# Your first library

У пакета сверху заголовок:

```go
// Package stringutil contains utility functions for working with strings.
package stringutil
```

Руна, похоже, символ в языке.

Есть соглашение, что имя пакета - последний элемент в пути.

Executable commands must use *package main*

# Testing

Файлы  заканчивающиеся на *_test.go*.
Содержат ф-и, названные как TestXXX с сигнатурой:
```
func (t *testing.T)
```
Если ф-я вызывает ф-и типа t.Error or t.Fail - тест сломан.

**go help <command>**

# Remote packages

go get github.com/golang/example/hello

Вытягивает и зависимости тоже.





