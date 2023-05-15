http://www.typescriptlang.org/docs/handbook/basic-types.html

# Tuple

```ts
let x: [string, number];
x = ['hello', 10]
// Можно обращаться к x[0], x[1].
```

Если обращаться за описанные индексы, можно юзать любой тип из указанных,
но нельзя юзать неуказанные типы.

=========

# Enum

```ts
enum Color {Red, Green, Blue}
let c: Color = Color.Green;
```

By default starts with 0.
`enum Coloer {Red = 1, ...}`

Можно присвоить значения индивидуально.
`enum Color {Red = 1, Green = 2, Blue = 4}`

Enum has hash
` Color[2] // Green `

===========

# Any

===========

# Void

Обычно для return value.
Переменным можно присваивать undefined or null.

# Undefined and Null

let u: undefined = undefined;
let n: null = null;

По умолчанию, можно присваивать null и undefined другим типам.
Но если сделаешь --strictNullChecks, то нельзя.
Рекомендуют юзать это.

=========

# Never

Для обозначений return type для функций, которые никогда не возвращаются.
Exceptoin or infinite cycle.

=========

# Object
Non primitive type.
null можно посылать в качестве object.

========

# Type assertions

Уточнение типов.

```
let someValue: any = "this is a string";

let strLength: number = (<string>someValue).length;


let strLength: number = (someValue as string).length;
```

http://www.typescriptlang.org/docs/handbook/variable-declarations.html


Объекты можно описывать как *readonly*.


Декларация типов после деструктуризации:
```
let { a, b }: { a: string, b: number } = o;
```

```

Doesn’t allow spreads of type parameters from generic functions. That feature is expected in future versions of the language.>>>>>>
```

Object spread - own enumerable.

http://www.typescriptlang.org/docs/handbook/interfaces.html


`compiler only checks that at least the ones required are present`

No need to implement interfaces. Just 'duck typing'.

Opional properties:

**readonly** (for props)

```ts
interface SquareConfig {
    color?: string;
    width?: number;
}
```

```ts
interface Point {
  readonly x: number;
}
```

Есть тип `ReadonlyArray`.

Object literals have excess property checking. It must only have properties
existing in target type (e.g. interface).


Обойти проверку типов можно

```ts
let mySquare = createSquare({ width: 100, opacity: 0.5 } as SquareConfig);

// Либо так:

interface SquareConfig {
    color?: string;
    width?: number;
    [propName: string]: any; // Any numbers of other properties.
}

// Or:

let squareOptions = { colour: "red", width: 100 };
let mySquare = createSquare(squareOptions);

```

Но обходить чеки === стрелять себе в ногу.

==============================

# Functions

```ts
interface SearchFunc {
    (source: string, subString: string): boolean;
}


// Parameter names do not need to match.
let mySearch: SearchFunc;
mySearch = function(src: string, sub: string): boolean {
    let result = src.search(sub);
    return result > -1;
}

// No need to specify types:

mySearch = function(src, sub) {
    let result = src.search(sub);
    return result > -1;
}

```
==============================

# Indexable

```ts

interface StringArray {
  [index: number]: string; // strings and numbers are supported as indexes.
}

```

# Classes


```
interface ClockInterface {
    currentTime: Date;
    setTime(d: Date);
}

class Clock implements ClockInterface {
    currentTime: Date;
    setTime(d: Date) {
        this.currentTime = d;
    }
    constructor(h: number, m: number) { }
}
```

Interfaces describe the public side of the class.

=====

Interfaces can extend each other.

```ts
interface Shape {
    color: string;
}

interface PenStroke {
    penWidth: number;
}

interface Square extends Shape, PenStroke {
    sideLength: number;
}
```


# Классы

Можно обращаться к родительскому классу через super.method. super() - вызов конструктора.

static readonly abstract.


# Модули

```ts
export interface StringValidator {
    isAcceptable(s: string): boolean;
}

export const numberRegexp = /^[0-9]+$/;

export class ZipCodeValidator implements StringValidator {
    isAcceptable(s: string) {
        return s.length === 5 && numberRegexp.test(s);
    }
}

export { ZipCodeValidator as mainValidator };
```

Реэкспорт:

```ts
// Экспортирует исходный валидатор, переименовывая его
export {ZipCodeValidator as RegExpBasedZipCodeValidator} from "./ZipCodeValidator";

export * from "./StringValidator"; // экспортирует интерфейс 'StringValidator'
export * from "./LettersOnlyValidator"; // экспортирует класс 'LettersOnlyValidator'
export * from "./ZipCodeValidator";  // экспортирует класс 'ZipCodeValidator'

```

```ts
import { ZipCodeValidator } from "./ZipCodeValidator";

let myValidator = new ZipCodeValidator();
импортируемый элемент также может быть переименован

import { ZipCodeValidator as ZCV } from "./ZipCodeValidator";
let myValidator = new ZCV();
```


Импорт всего модуля в одну переменную.
```ts
import * as validator from "./ZipCodeValidator";
let myValidator = new validator.ZipCodeValidator();
```

Ради побочных эффектов
```ts
import "./my-module.js";
```

```ts

export default "someString";

export default class A {

}
export default function B() {

}

import a from "./a.js";

```


```ts
export = ZipCodeValidator; // class, interface, namespace, function, or enum

import zip = require("./ZipCodeValidator");

```

`--module commonjs`


============

# namespaces

Previously "internal modules".

Раньше был keyword `module`, теперь `namespace`.

`export` делает ф-и и переменные неймспейса доступными вне неймспейса.

One namespace can be separated to a few files.


`import` poligons = Shapes.Polygons.
Для значений - альяс создает копию.
Для объектов - не сказано.

Неймспейсы превращаются в такой JS:

```js
(function (Utility) {

// Add stuff to Utility

})(Utility || (Utility = {}));
```

--outFile позволяет соединять несколько ts в один js.











==============================


# Migration.





Дочитать доку по миграции.
Как делать cmd line утилиты на TS.
Перетащить парсинг параметров в отдельный файл.

Как решить проблемы с изменением путей ?
Как мы её решаем в smp проекте?







































