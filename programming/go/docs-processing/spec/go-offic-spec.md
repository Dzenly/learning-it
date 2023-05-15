# https://golang.org/ref/spec

Strongly typed. Gargabe-collected.
Explicit support for concurrent programming.

Programs are constructed from packages.

Compile/link model to generate executable.

# Source code representation

UTF-8. Case-sensitive.

# Lexical elements

## Comments

`//, /* */`
Коммент без newline работает как space. А с newline - как newline.

## Токены

4 класса: идентификаторы, ключевые слова, операторы и разделители, литералы.

?? Newline or EOF may trigger insertion of a semicolon.

## Semicolons

В формальной грамматике использутся как терминатор.
В Go программе можно опускать большинство из этих semicolons, using the following 2 rules:

1. When the input is broken into tokens, a semicolon is automatically inserted into the token stream immediately after a line's final token if that token is:

  * an identifier
  * literal (integer, floating-point, imaginary, rune, string)
  * one of the keywords: break, continue, fallthrough, return
  * one of the operators and delimiters: ++, --, ), ], }

2. При нескольких statements on a single line, semicolon can be omited before ) and }.

# Identifiers

Identifies program entities such as variables and types.
Первый символ - letter (not a digit).

Можно юзать любые Unicode символы, хоть на греческом пиши.

# Keywords

Не могут быть использованы как идентификаторы.

break, case, chan, const, continue, default, defer, else, fallthrough,
for, func, go, goto, if, import, interface, map, package, range, return, selet, struct, switch, type, var.

# Operators and Delimiters

```
+ - * / % <space> & | ^ << >> $^ += -= *= /= %= &= |= ^= <<= >>= $^= && ||
<- ++ -- == < > = ! != <= >= := ... ( [ { , . ; : } ] )
```

# Integer literals

0 prefix for octal, 0x (0X) for hex.

# Floating-point

```go
0.
72.40
072.40  // == 72.40 Типа - не восьмеричная.
2.71828
1.e+0
6.67428e-11
1E6
.25
.12345E+5
```

# Imaginary literals

imaginary_lit = (decimals | float_lit) "i"

```go
0i
011i  // == 11i
0.i
2.71828i
1.e+0i
6.67428e-11i
1E6i
.25i
.12345E+5i
```

# Rune literals

Unicode code point.

One or more characters enclosed in single quotes: like 'x', '\n'.
Любой символ разрешен, кроме EOL и unescaped single quote.

# String literals

## Raw
`foo`.
Backslash no special meaning.
Can cointan EOLs.
Cariage return - discarded.

## Interpreted.
"bar"
No newlines and unescaped double quote.
Можно задавать побайтово, можно через unicode code points, можно через суррогаты.

# Constants

Может содержать только constant expression. Т.е. как я понял вычисляется при Compile Time.

Rune - относится к числовым.

Можно юзать некоторые build it ф-и.

true / false.

iota - predefined identifier for integer consts.

Нет констант для -0, infinity, NaN.

Constants may be untyped.
Надо глянуть поболе инфы в constant expressions.

Тип константы может быть задан явно, в декларации или с использованием ф-й для приведения типов.

А может задаваться неявно.

An untyped constant has a default type, это тип, в который конвертится константа в контекстх, где нужно типизированное значение.

Дефолтные типы для констант: bool, rune, int, float64, complex128, string.

*Важно: в языке можно задавать любую точность, но имплементация может содержать ограничения:*

But, every implementation must (и для литералов и для результатов const exp):

* use at least 256 bits for integer const.
* use at least 256 bit for mantissa and 16 bits for exponent.
* выдавать ошибку, если не может представить точно целочисленную константу.
* выдавать ошибку при overflow при вычислении floating-point constant
* если не может представить fp const то округлять к ближайшей представимой.

## Variables

Содержит value. Разрешенные values определяются типом.

Декларация переменной, декларация функций (параметры, возвращаемое значение, литерал функции).

Вызов *new* или взятие адреса композитного литерала аллоцирует память at RT.
Такие анонимные переменные is referenced to via a *pointer indirection*.

& - взятие адреса.
* - взятие значение по адресу.

Если указатель nil - то разименование = panic.

У массивов, слайсов, структур - можно получать адреса внутренних элементов.

Статический тип переменной назначается в декларации, при вызове new или ещё как-то.
В общем, как я понял в CT.

Для переменных с типом "интерфейс" есть динамический тип.

nil не имеет типа.

Есть инициализация по умолчанию для заданного типа.


## Types

Есть некие unnamed types, которые задаются через литерал type.

```go
type T1 string
type T2 T1
type T3 []T1
type T4 T3
```

## Method sets

Для типа интерфейс это интерфейс.

Для других типов - это методы, где receiver - это тип.

Набор методов для указателя на тип T включает также набор методов для самого типа T.

См. секцию про анонимные поля структуры и их method sets.

## Boolean types

bool, true, false.

## Numeric types

uintX (8, 16, 32, 64).

intX

float32, float64

complex64 (32float real, 32float imaginary)
complex128

byte - alias for uint8.
rune - alias for int32.

Все неальясы - считаются разными типами, т.е. преобразовываются в соответствующих выражениях.

### Implementation specific ones:

uint - 32 or 64 bits.
int - same
unitptr - large enough to store uninterpreted bits of a pointer value.

uninterpreted - это значит не заморачиваться на какую область памяти он указывает.
Нужно для поинтерной арифметики.

## String types

immutable.

len - в байтах.

s[i] - i-th byte.

&s[i] - invalid, it is illegal to take the address of such an element.

## Array types

Длина - часть типа, неотрицательная константа, которую можно запихнуть в int.

len

```go
[32]byte
[2*N] struct { x, y int32 }
[1000]*float64
[3][5]int
[2][2][2]float64  // same as [2]([2]([2]float64))

b := [2]string{"Penn", "Teller"}

b := [...]string{"Penn", "Teller"}

```

## Slice types

Описывает непрерывный сегмент of an underlying array.
В отличие от массивов - длина может меняться.

Шарят память с низлежащими массивами.

?? Есть ли неявные слайсы ??

capacity - насколько underlying array может быть за границей slice.

cap


```go

letters := []string{"a", "b", "c", "d"}

// Эквивалентные записи
make([]int, 50, 100) // make allocates the array
new([100]int)[0:50]
```

https://tour.golang.org/moretypes/11
https://blog.golang.org/go-slices-usage-and-internals

## Struct types

Имена полей могу задаваться явно и неявно (анонимно).

```go
// An empty struct.
struct {}

// A struct with 6 fields.
struct {
	x, y int
	u float32
	_ float32  // padding
	A *[]int
	F func()
}

// A struct with four anonymous fields of type T1, *T2, P.T3 and *P.T4
struct {
	T1        // field name is T1
	*T2       // field name is T2
	P.T3      // field name is T3
	*P.T4     // field name is T4
	x, y int  // field names are x and y
}
```

Имена полей должны быть уникальны, даже если они неявные.

Promoted - филд или метод анонимного филда в структуре x.
Если x.f - легальный селектор.


```go
type Person struct {
    name string
    age int32
}
func (p Person) IsAdult() bool {
    return p.age >= 18
}
type Employee struct {
    position string
}
func (e Employee) IsManager() bool {
    return e.position == "manager"
}
type Record struct {
    Person
    Employee
}
...
record := Record{}
record.name = "Michał"
record.age = 29
record.position = "software engineer"
fmt.Println(record) // {{Michał 29} {software engineer}}
fmt.Println(record.name) // Michał
fmt.Println(record.age) // 29
fmt.Println(record.position) // software engineer
fmt.Println(record.IsAdult()) // true
fmt.Println(record.IsManager()) // false

// Но, вот так - нельзя.
record := Record{name: "Michał", age: 29}

// А вот так - можно.
record := Record{Person{name: "Michał", age: 29}, Employee{position: "Software Engineer"}}
```

Если есть struct type S и type T, promoted methods are included in the method set of the struct as follows:

* Если S содержит T, method set S и S* включает promoted methods of receiver T.
  `*S` включает также receiver `*T`.
* Если S содержит `*T`, S и `S*` содержат методы с receivers T or `*T`.

После декларации филда может быть литерал `tag`, такой аттрибут филда, его видно в reflection interface.
Это, похоже, что-то типа встроенного коммента в PG SQL.

http://golangtutorials.blogspot.ru/2011/06/anonymous-fields-in-structs-like-object.html

```go
type Kitchen struct {
    numOfLamps int
}

type House struct {
    Kitchen
    numOfLamps int // Hides kitchen numOfLamps, so qualifying required.
}

// ===============

type Kitchen struct {
    numOfLamps int
}

type Bedroom struct {
    numOfLamps int
}

type House struct {
    Kitchen
    Bedroom
}

func main() {
    h := House{Kitchen{2}, Bedroom{3}} //kitchen has 2 lamps, Bedroom has 3 lamps
    fmt.Println("Ambiguous number of lamps:", h.numOfLamps) //this is an error due to ambiguousness - is it Kitchen.numOfLamps or Bedroom.numOfLamps
}


// h.Kitchen.numOfLamps + h.Bedroom.numOfLamps - ok.


```


## Interface types

Задает набор.



















## Receive operator

<-ch - значение, полученное из канала ch.
Тип определяется каналом.
Блокирует код данной ф-и, пока в канале не появится значение.
Если канал nil - блокировка навечно.

Для закрытого канала, как я понял позволит считать что там было, а потом
будет возвращать zero value типа канала.

Можно использовать без присвоения, можно в вызовах ф-й.


















