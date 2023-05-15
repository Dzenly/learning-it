New - возвращает указатель. make - значение.

Типа make - для инициализации slices, maps, channels.

```go
// Using make() to initialize a map.
m := make(map[string]bool, 0)

// Using a composite literal to initialize a map.
m := map[string]bool{}
```

https://dave.cheney.net/2014/08/17/go-has-both-make-and-new-functions-what-gives

При new идет инициализация.

new берет только один аргумент - тип.

