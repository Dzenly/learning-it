https://golang.org/doc/effective_go.html

# Examples - есть в документации по пакетам.

# Formatting

gofmt

По умолчанию юзаются табы.

?? Длинные линии за счет дополнительной индентации ??

Меньше скобок, чем в C++. Они необязательны в if, for, switch.

Меньше список operator precedence.

```go
Precedence    Operator
    5             *  /  %  <<  >>  &  &^
    4             +  -  |  ^
    3             ==  !=  <  <=  >  >=
    2             &&
    1             ||
```

# Комментарии

```go
/* block comments */ 
// line comments
```

godoc - программа и web server.
Процессит комменты в сорцах.

Комменты (без промежуточных EOL) перед декларацией - extracted with declaration.

*package comment* - перед package clause.
For multi-file package needed to be present в одном (любом файле).
Форматирование не сохранится.
**indented text displayed in fixed width font**

В некоторых контекстах, godoc сохраняет формат комментов, поэтому, например, не надо писать сильно длинные строки.

Все capitalized имена в пакете экспортируются. И должны иметь комменты.

Первое предложение в комменте к декларации должно начинаться с имени декларируемой сущности. Тогда хорошо искать по документации. *This function* **не добавляет смысла в коммент**.

Группировка деклараций может задавать какую-то связь между сущностями.

# Names

## Package names

import "bytes"
bytes.Buffer

Имена пакетов должны быть лаконичными и evocative.

Lower case, single-word names.
Без подчеркиваний и больших букв.

Коллизии - не проблема. При импорте можно менять дефолтное имя на своё.

Пакет из src/encoding/base64 импортируется как encoding/base64
и юзается base64.

Есть синтаксис 'import .'.

```go
package ring

// constructor
Ring // плохо
NewRing // плохо
New // хорошо!

```

Смотреть что лучше - длинное имя, или doc comment.

## Getters

Не обязательно у геттера юзать префикс Get.

```go
Owner // not GetOwner
SetOwner // good.
```

Для приватного филда owner - геттер Owner.

Поле - lower case, method - upper case и легко отличить геттер от самого поля.

## Interface names

Соглашение: интерфейс с одним именем называть как это имя + er.
Reader, Writer, Formatter, CloseNotifier

Лучше не давать своим методам сильно распространенные имена (Read, Write, Close, Flush, String...), если они не имеют
того же смысла. И наоборот, давать, если смысл тот же. Например, не ToString (для конвертера), а String.

## MixedCaps

mixedCaps вместо underscores (go convention).


# Semicolons

Go's formal grammer юзает точки с запятой, но они вставляются автоматом, поэтому
в большинстве случаев в коде не нужны.

Правило: если последний токен перед EOL - идентификатор (включая идентификатор типа),
базовый литерал, или один из токенов:

break continue fallthrough return ++ -- ) }

lexer вставит точку с запятой.

"если EOL идет после токена, который может завершать statement - вставь semicolon".

Не нужна перед закрывающей }.

Разделяет initializer, condidtion, continuation elements in for.

Разделяет multiple statements on a line.

Открывающая { не переносится на следующую строку.
  
# Control structures

Для циклов только for.

switch погибче, чем в C.

if and switch accept an optional initialization element (like for for).
break and continue take label.

Есть switch для типов.

Есть multiway communications multiplexer, select.

Не надо скобок для if и switch, блок всегда в {}.
  
## If

Инициализация локальной переменной:

```go
if err := file.Chmod(0664); err != nil {
    log.Print(err)
    return err
}


// Пример обработки ошибок:
f, err := os.Open(name)
if err != nil {
    return err
}
d, err := f.Stat() // redeclaration for err.
if err != nil {
    f.Close()
    return err
}
codeUsing(f, d)
```

## Redeclaration and reassignment

Условия легальной редекларации через :=

* Редекларация в том же скопе, что и декларация (если v есть во внешнем скопе, редекларация v создаст новую переменную и скроет внешнюю).
* то, что мы пытаемся присвоить v - assignable to v.
* есть как минимум одна переменная, которая раньше не была декларирована в этом скопе.

Скоп, для параметров функций и возвращаемых значений тот же, что и для function body.

## For

Есть три формы цикла.

```go
// Like a C for
for init; condition; post { }

// Like a C while
for condition { }

// Like a C for(;;)
for { }

sum := 0
for i := 0; i < 10; i++ { // Short declaration.
    sum += i
}

// array, slice, string, map, channel.
for key, value := range oldMap {
    newMap[key] = value
}

// key := range m
// _, value := range m
// _ - *blank identifier*

```

range разбивает строки на руны.

*Нет , оператора, но есть параллельное присваивание (даже без инициализации)*

```go
// Reverse a
for i, j := 0, len(a)-1; i < j; i, j = i+1, j-1 {
    a[i], a[j] = a[j], a[i]
}
```

# switch

Можно юзать вместо if else if else.

Выражение может быть переменной и не целым.
Если нет expression - считается, что оно true.

case содержит условие.

Нет fall through.

Cases can be presented in comma separated list.

```go
switch c {
   case ' ', '?', '&', '=', '#', '+', '%':
       return true
   }
   return false
```

break [label] - прерывает switch или цикл.

continue [label] - только для циклов.









  


































