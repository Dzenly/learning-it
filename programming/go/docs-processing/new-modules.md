https://habr.com/ru/post/421411/

Major version - new module.

module github.com/robteix/testmod/v2

====

go build - сходит и подтянет нужные пакеты.

go mod tidy - clean dependencies.
by default old dependencies is not removed.

При использовании модулей команда go полностью игнорирует каталоги поставщиков (vendor directories).
https://golang-blog.blogspot.com/2019/07/modules-and-vendoring.html

Команды go build и go test, автоматически загрузят все отсутствующие зависимости, хотя вы можете сделать это явно с помощью go mod download, чтобы предварительно заполнить локальные кэши, которые могут оказаться полезными для CI.

По умолчанию все наши пакеты из всех проектов загружаются в каталог $GOPATH/pkg/mod.

https://habr.com/ru/company/oleg-bunin/blog/467697/

GOPROXY




