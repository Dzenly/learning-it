https://tproger.ru/translations/yaml-za-5-minut-sintaksis-i-osnovnye-vozmozhnosti/

Yaml is not a Markup language ?

`---` - три дефиса - разделитель документов.

Комменты после `#`.
Многострочные не поддерживаются.

Пробелы, а не табы. Два пробела.

!!int 14.10
!!str 23.43

* int
* float
* boolean
* string
* null

.inf
-.Inf
.NAN

`|` - строки.
`>` - параграфы.

in flow
```yaml
prods: [milk, eggs, juice]
```

block
```yaml
prods:
  - milk
  - eggs
  - juice
```

# Словари

```yaml
Employees:
- dan:
    name: Dan D. Veloper
    job: Developer
    team: DevOps
- dora:
   name: Dora D. Veloper
   job: Project Manager
   team: Web Subscriptions
```

`:` - Разделяет ключ и значение.

Строки можно без кавычек.
Кавычки - если есть спец. символы.
Одинарные кавычки - спец символы как литералы.

# folded style > / >- / >+

# literal style | /  |- / |+

```
application: { Install: "Vscode", Remove: Stacer, Update: Firefox}
```

```
application1:
 Install: Vscode
 Remove: Stacer
 Update: Firefox
```

```
<< переопределение значений


```










