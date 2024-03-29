https://blog.golang.org/go-slices-usage-and-internals

# Arrays

Размер массива фиксирован.

Инициируются автоматом.

В памяти идут непрерывно.

По умолчанию передаются по значению, т.е. копируются.

```go
// Array literal initializers.
b := [2]string{"Penn", "Teller"}
b := [...]string{"Penn", "Teller"}

// Both cases type is: [2]string
```

# Slices

Применяются чаще, чем массивы.

Длина не фиксирована.

```go
// Литерал как в массиве, но без указания длины и многоточия.
b := []string{"Penn", "Teller"}

var s []byte
s = make([]byte, 5, 5)
```

Если не задал capacity - оно будет как длина.

Zero value для слайса это nil, len & cap are 0.

Можно создавать слайс из готового массива.

```go
s := x[1:4]
```

Можно создавать слайс из слайса.

Слайс не может расти больше, чем его capacity, иначе RT panic.

Слайсы не могут реслайситься, чтобы указывать на предыдующие элементы массива.

Чтобы увеличить размер slice нужно создать новый slice с большей capacity.

copy корректно работает, когда src и dst шарят один массив.

Есть встроенная ф-я append. 

...sliceName - expand slice в append например.

Слайсы могут отнимать много памяти. Если весь underlying array не нужен, но слайс, ссылающийся на этот массив, приводит к тому, что GC не может удалить массив.
В таком случае лучше бы скопировать слайс в новый слайс.

