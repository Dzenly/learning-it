https://habr.com/ru/articles/685518/

Код может переупорядочиться на уровне:

1. Компилятора в байткод (javac).
2. Компилятора в машиннй код (JIT компилятор HotSpot C1/C2). Например есть оптимизация: Instruction scheduling.
3. Процессора. Out-of-Order execution, Branch Prediction + Speculation, Prefetching.


Java дает as-if-serial гарантию. Но только на уровне треда.
Процессоры тоже переупорядочивают только если это не меняет итогового результата.
Cache Coherence обеспечивает консистентность кэшей по всем ядрам.

jcstress - тесты на конкурентность для Java.

hsdis - дизассемблер.

`java -server -XX:+UnlockDiagnosticVMOptions -XX:+StressLCM -XX:+StressGCM -XX:-TieredCompilation -XX:+PrintAssembly -XX:PrintAssemblyOptions=intel JmmDekkerInstructionsReorderingJIT`

# Введение: JMM

Есть кое-какие гарантии микроархитектур процов. Но например на ARM гарантии довольно слабые.

Модель памяти:

* Разрешает выполнение оптимизаций компилятора, JVM или процессора.
* Закрепляет условия, при которых программа считается правильно синхронизированной.
* Описывает отношение между высокоуровневым кодом и памятью.
* Компромисс между строгостью исполнения кода и оптимизациями.

По умолчанию JMM разрешает переупорядочивания, и не гарантирует видимости изменений.
Только если соблюдать некоторые условия эти параметры будут гарантированы.

# Memory Ordering

Описывает наблюдаемый порядок, в котором происходят действия с памятью.

Порядок взаимодействия с памятью (memory order)
может отличаться от порядка действий в коде (program order).

М.б. такое что

(Dekker Lock)

Thread 0	Thread 1
x = 1	    y = 1
r1 = y 	r2 = x

В итоге даст 0, 0 d r1 и r2.

Это будет ?StoreLoad?
Т.е. запись произошла после чтения (x, и y).
Со стороны программы смотрится как неконсистентность действий с памятью.

* Если программа не синхронизирована, запрещены все переупорядочивания.
* Если не синхронизирована, то memory order, неконсистентный с pogram order, валиден с точки зрения JMM. Если синхронизирована, то валиден только консистентный порядок.

# Виды Memory Reordering

* LoadLoad - переупорядочивание чтений с другими чтениями.
* LoadStore - r, w -> w, r.
* StoreStore -
* StoreLoad - w, r -> r, w

Типы модели памяти

* Sequential Consistency: запрещены все переупорядочивания
* Relaxed Consistency: разрешены некоторые переупорядочивания
* Weak Consistency: разрешены все переупорядочивания

Intel процы разрешают только StoreLoad переупорядочивания.
ARM - разрешает все переупорядочивания.

Но это процы. А JVM по умолчанию разрешает все переупорядочивания.

# Sequential Consistency

Строгая модель. Нет переупорядочиваний.
"Как будто" операции на всех процессорах были выполнены в заданной последовательности. Под капотом может делаться что угодно,
но в результате это не должно повлиять.

# Sequential Consistency-Data Race Free

Нужно избавиться от всех Data Race.

А вот, например, какую оптимизацию компилятор может сделать:
Thread 0	Thread 1
r1 = 1	r2 = 1
Компилятор полностью убрал записи и просто заинлайнил значения в чтения.

Т.е. если есть хотя бы один вариант, который дает получаемый порядок -
переупорядочивания валидны.

# Data Race

С общими данными работает больше 1 треда и как минимум один из них пишет
без синхронизации.

Для data race не гарантируется никакие memory orders.


# Shared Variables

Heap memory shared between threads.

Поля экземпляров, статические поля, элементы массивов хранятся в куче.
Два доступа к одной переменной называются конфликтующими, если
как минимум одно пишет.

# Happens-before order

Когда есть два конфликтующих доступа, которые не упорядочены по
happens-before отношению, говорят что мы имеем data race.

SA - Syncronization actions.
SO - Synchronization orders.

Порядок действий с памяться консистентен с порядком программы.
Каждое чтение всегда видит предыдущую запись.

====

Запись и чтение volatile переменной.
Взятие и освобождение монитора.

Dekker Lock

# JMM: Happens-before: теория

Во время выполнения y треду T2 будут видны результаты x, выполненные T1.

## HB Same thread actions

В одном треде всегда выполняется happens-before.

## HB Monitor lock

Unlock on monitor m happens before all subsequent locks on m.

## HB Volatile

Write to volatile var v, happens before all subsequent reads of v by any thread?
Я так понял имеется в виду, что результаты записи будут видны всем читателям.

## HB Final thread action

Финальное действие в треде T1 happens before в T2, которые поймут, что тред T1 завершен.

T1.join in T2.
T1.isAlive in T2 (if returns false)

## HB Thread start action

Thread.start happens before any action in this thread.

## HB Thread interrupt action

T1 interrupts T2. Interrupt by T1 happens before any point
where any other thread (including T2) determines that T2 interrupted.

## HB Default init

Дефолтные инициализации переменных happens before первое действие в этом треде.

====

## HB транзитивность

hb(x,y) AND hb(y,z) => hb(x,z)

Т.е.

* Все действия до освобождения монитора одним тредом видны другому треду после захвата монитора.
* И т.д. по всем HB примерам.

## JMM: HB: Практика


Monitor Lock
Предоставляет happens before и является мьютексом.
Каждый объект в Java содержит возможность лока, с помощью syncronized.
(intrinsic lock)

Volatile

Все изменения перед записью тоже будут гарантированно видны
тредам, читающим volatile.

acquire/release семантика.
Safe publication.

Acquire принимает изменения.
Release - публикует изменения.

Когенентность кэша.
Любое ядро читает самое актуальное значение из кэша.


==========


## Memory Barriers

Процессорные переупорядочивания гарантируют результаты как если бы упорядочиваний не было, но только для одного ядра.

JMM ответственна зя синхрон на уровне проца.

Процессоры предоставляют эти Memory Barriers.
Т.е. запреты на переупорядочивания.
Используются под капотом из JVM.
(Memory Fence)
LoadLoad
LoadStore
StoreStore
StoreLoad

==========

# Итоги

* javac - обеспечивает порядок bytecode инструкций, который будет
консистентен с порядком действий в коде.

* Компилятор в машинный код (HotSpot JIT Compiler C1/C2)
Обеспечивает порядок машинных инструкций, консистентный с порядком
действий в коде.

* CPU Memory ordering.
Расставляет барьеры в нужных местах, чтобы mem ordering машинных инструкций
был конистентен с порядком действий в коде.

=======

# JMM: Atomicity

* Чтения и записи reference переменных.
* примитивов, кроме long и double.
* volatile long/double

# JMM: Final fields

final - если инициирована ссылка, то значит и внутренние поля инициированы.
Safe initialization.

======

# Benign data races





















https://www.youtube.com/watch?v=Elzrmnbhz2E&ab_channel=AleksandrMenshikov



https://www.youtube.com/watch?v=Ao7qoAc9AGc&ab_channel=%D0%9B%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D0%B9%D0%A4%D0%9F%D0%9C%D0%98


https://www.youtube.com/watch?v=eIvC6MgFbG4&ab_channel=HSECS-JointdepartmentwithJetBrains







