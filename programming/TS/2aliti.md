http://2ality.com/2018/04/type-notation-typescript.html

Use `--strict`.

TS adds `static` type to JS.

TS не инициирует let x: number; нулем.
Он просто не дает юзать x, пока не присвоишь его.

TS может выводить типы let x = 12;

То, что после `:` called `type expression`.

Типы для null и  undefined пишутся как null и undefined, без кавычек.


```ts
function stringify123(callback: (num: number) => string) {
  return callback(123);
}
```
void function can return undefined.

``?`` - for optional values.


TS tracks checks for optiona params:
```ts
function stringify123(callback?: (num: number) => string) {
  const num = 123;
  if (callback) { // Without this if - here will be an error.
    return callback(num); // (A)
  }
  return String(num);
}
```

```ts
let x: null|number = null;
x = 123;
```

М.б. имеет смысл задавать параметр через null | T.
Called will always know parameters.


```ts
interface Point {
  x: number;
  y: number;
  distance(other: Point): number;
}
```

```ts
function id<T>(x: T): T {
  return x;
}

id<number>(123);

//Due to type inference, you can also omit the type parameter:
id(123);

// Можно пробрасывать тип в ф-ю:

function fillArray<T>(len: number, elem: T) {
  return new Array<T>(len).fill(elem);
}

```









