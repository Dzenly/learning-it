https://www.youtube.com/watch?v=Y1fzzw-wESk&ab_channel=%D0%9E%D0%A2%D0%A0%D0%9E%D1%80%D0%B3%D0%B0%D0%BD%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D0%BE-%D1%82%D0%B5%D1%85%D0%BD%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B5%D1%80%D0%B5%D1%88%D0%B5%D0%BD%D0%B8%D1%8F


# XRebel (профилирование Web приложений)

Подсвечивает узкие места.

# Head-Dump

Можно отследить размножение объектов.

# Threads-Dump

Можно посмотреть тоже какие треды размножаются. Чего ждут.

# JFR-Logs

?JVM File Recorder ?

Можно поанализировать данные и историю их жизни.

# SQL. Explain, План запроса.

Виды чтения. Индексы.
ANALYZE


https://www.youtube.com/watch?v=alLu-Ufe4NE&ab_channel=IT2GCompany

Виктор Вербитский

Источники проблем с производительностью:

* Алгоритмическая сложность. Не вынесенная константа. Незнание библиотечных функций, изобретение велосипедов. Оверинжиниринг (перебор с "а что если").
* Избыточный ввод-вывод.
* Избыточная синхронизация и ожидания. Дедлоки. Theads contention. Ожидание блокировки - почти не расходует ресурсы, а вот момент взятия - расходует.
И ещё есть спинлоки.
* Проблемы JIT. Спекулятивные оптимизации. Бывает много кода. Ошибки предсказаний - расходы. Статистика переходов.
* Нехватка памяти / утечки памяти.
* Safe Point
* Внешние причины.

======

C1 и C2 - два JIT компилятора, включенных в HotSpot JVM.
C1 - client compiler. Optimized for APPs that have
a short start-up time. Compiled faster then C2,
but slightly slower code.
Имеет точки профилирования.
С2 - server compiler for long-running apps,
high throughput, low latency.
Takes longer to compile.

`-XX:+TieredCompilation`

can be enabled in java 7.
default in java 8.

======

Единица компиляции - метод.


* Dead code Elimination
* Escape Analysys. Только для небольших методов.
* On Stack Allocation (для используемых полей). Нет нагрузки на GC.
* Inlining
* Intrinsic (заготовки на машинном коде). Иногда нет смысла смотреть библитеку на Java, т.к. некоторые либы, например, Math, покрыты интринсиками.

Смена профилей нагрузок от времени суток.
Мешает оптимизациям.
20 минут не выполнялся код - выкидываем.

Куче нужно свободное пространство.
Скорость генерации мусора.

Гипотезы:
* Большинство объектов умирают молодыми.
* Старые объекты редко ссылаются на молодые.

Safe Points

Останов потоков.
Сбор стек трейсов.
DDR4 быстрее DDR3 ?

Настройки виртуальной машины и их драйвера.

* base line
* Изменения относительно base line.

Учитывать прогревы.
Т.е. сколько-то прогонов без замеров.

Инструменты:

jps -l

# jstack

* Собирает стектрейсы всех потоков.
* Блокировки в потоках.
* dead locks.

При снятии дампов потоки останаливаются на Safe Points.
Т.е. момент уже не тот, в который вы вызвали команду.

`-XX:+PreserveFramePointer`

fastthread.io

jstat -gc

FGC - Full GC
FGCT - Time Spent on Full GC
YGCT - Young GC Time

ЛОги GC

```
-XX:+PrintGC
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
-XX:+PrintGCCause
-XX:+PrintPromotionFailure
-Xloggc:/path/to/log/file
```

jmap -dump:live,format=b,file=heap.bin id

JFR
JMC

VisualVM
Если без семплирование то сильный отрыв от актуальности.

JProfiler, YourKit. С высоты птичьего полета.

**Async Profiler**
Андрей Паньгин.

Семплирование через внутренние механизмы OpenJDK, не привязан к Safe Points.

Показывает и байт код и нативный код (вплоть до работы ядра линукс), профилирует и CPU и выделение памяти и много чего ещё.
Результаты в виде Flame Graph.
Маленькие накладные расходы. Одноклассники юзают его в проде.
С кубером - осторожней.

**Eclipse Memory Analyzer**
Позволяет работать с большими дампами.

Алексей Рогозин - тренинги по профилированию.

Внедрение профилирования в CI/CD ?




















