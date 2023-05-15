# http://elliotchance.postach.io/post/godoc-tips-tricks

Brief package overview.
Непрерывный коммент перед `package *`, пустой строки быть не должно.

Пакет может быть собран из нескольких файлов. godoc соберет описания из всех файлов.
Порядок, вроде, не детерминирован.

Можно добавить файл, который содержит один элемент `package` и в нем все описать.


Параграфы.

```go
// Here is where we explain the package.
//
// Some other stuff.
package doc
```

Документация констант:

```go
// This is the host
const Host = "example.com"

// The port number for the host.
const Port = 1234


// This appears UNDER the const.
const (
    // This causes Foo to happen.
    OptionFoo = 1

    // This causes Bar to happen.
    OptionBar = 2

    // Documented, but not visible.
    optionSecret = 3
)
```

Так же можно описывать методы.


Heading and Sections:

Начинается с большой буквы, но перед концом строки нет точки.


Блоки кода - лишний пробел после //. Поддержки цветов пока нет.

```go
// This is how to create a Hello World:
//  fmt.Printf("Hello, World")
// Or:
//  fmt.Printf("Hello, " + name)
```

Гиперлинки распознаются автоматом.

```go
// See https://godoc.org for more information.
```


Ф-я Example() - это package level example.
Тело ф-и идет в док с подзаголовком Example.

?? Недопонял что за test package (with a `_test` suffix).
Наверное если назвать package с этим суффиксом он будет весь как Example ??


Examples to types:

```go
package doc

// Real is just another name for float64.
type Real float64

package doc_test

// Use Real like a general floating type:
func ExampleReal() {
    var x Real = 1.23
}
```

Underscore - разделяет examples.

```go
package doc

// Absolute value.
func Abs(x Real) Real {
}

package doc_test

func ExampleAbs_positive() {
    Abs(1.23)
    // Output: 1.23
}

func ExampleAbs_negative() {
    Abs(-1.23)
    // Output: 1.23
}
```

===============================================

# http://golang-for-python-programmers.readthedocs.io/en/latest/doc.html

Можно юзать и `/* */` комменты.

?? Имена с заглавной буквы - экспортируются.

Типа хорошая практика - начинать коммент с имени того, что комментируешь (ф-я, константа).

Ещё хорошо добавлять каких-то ключевых слов, а потом можно грепать по доку.

А вот 'This function' - не содержит инфы.

===============================================

# https://www.goinggo.net/2013/06/documenting-go-code-with-godoc.html

Табуляция как-то влияет на highlighting.


===============================================

# https://blog.golang.org/godoc-documenting-go-code

godoc парсит не только комменты, а весь код.

HTML формат позволяет быстро переключиться из документации на имплементацию.

Нет какого-то особого синтаксиса для комментов. Как в JavaDoc.

*Коммент начинается с имени того, что он описывает.*

Можно юзать отдельный файл *doc.go* содержит только комменты и package clause.

*Первое предложение идет в godoc package list*.

Known bugs:

// BUG(who): The rule Title uses for word boundaries does not handle Unicode punctuation properly.

Deprecated - добавляешь параграф с Deprecated: some info.

===============================================

https://godoc.org/golang.org/x/tools/cmd/godoc







