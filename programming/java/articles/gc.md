https://www.oracle.com/webfolder/technetwork/tutorials/obe/java/gc01/index.html

Referenced - есть где-то указатель.
Unreferenced - указателя нигде нет.

# Step 1. Marking

GC identifies which pieces of memory are in use and which are not.
This step can be time consuming.

# Step 2. Normal Deletion

Removes unreferenced objects.

Memory Allocator holds references to blocks of free space where
new objects can be allocated.

# Step 2a: Deletion with Compacting

Compact remaining referenced objects, by moving them together.
New mallocs are much faster.

# Why Generational GC?

Empirical analysis of apps has shown that most objects are short lived.

# JVM Generations

Инфа о поведении при аллокации объектов полезна
на улучшения производительности.
Куча разбивается на поколения:

## Young (когда заполняется - minor GC)
Объекты, которые выживают - стареют и однажды перемещаются в Old Generation.
All *minor GCs* are always "Stop the World events".

## Old (Tenured)
*major GC* (also StW).
Involves all live objects, so slower than minor GC.
Уменьшает отзывчивость приложения.
Время на StW зависит от типа выбранного GC.

## Permanent
Metadata required by JVM to describe classes and methods
used in the app (and for Java SE lib classes and methods).

Classes may get collected (unloaded) if JVM finds that space is needed for other classes.

Permanent generation is included in a *full GC*

# The generational GC process

Any new object is allocated to the Eden Space.
Survivor spaces start out empty.

When Eden Space fills up - minor GC is triggered.
Referenced objects are moved to the first survivor space (S0).
Unreferenced objs are deleted when Eden space is cleared.

S0 SS (Survivor Space)
S1 SS

At next minor GC, objects are moved to S1 (?from Eden ?).
SO objects are incremented in Age and moved to S1.
So S1 has differenly aged objects.

next minor GC
Survival Space Switch.
Referenced objs aged and moved to S0.
Eden and S1 are cleared.

Age threshold (e.g. 8)
they are promoted from young gen to old gen.

Однажды, major GC выполняется на Old Gen для очистки и сжатия спейса.

# Performing your own observations

Open BUsiness Engine

**jvisualvm**

Tools->Plugins
Visual GC

* Overview
* Monitor
* Threads
* Sampler
* Profiler
* Visual GC

heapdump

# Java GCs

Common Heap Related Switches

-Xms - initial heap size when JVM starts.
-Xmx - max heap size
-Xmn - size of Young Generation
-XX:PermSize - starting size of permanent gen
-XX:MaxPermSize

## Serial GC

Default in Java 5 and 6.

minor and major GCs are done serially (using a single virtual CPU).

Mark-compact collection method.
Moves older memory to the beginning of the heap
so that new mem allocs are made into a single
continuous chunk of memory at the end of the heap.
Типа быстро аллоцируются новые чанки.

For Apps that do not have low pause time requirements
and run on ?client-style? machines.
Can efficiently manage apps with a few hundred MBs of Java Heap,
with relative short worst-case pauses (a couple of seconds for full GC).

Another case - много JVMs на одной машине (больше чем процов).
Тут хорошо юзать один проц, чтобы не влиять на другие JVMs,
даже если GC долго.

Embedded HW with minimal memory and few cores.

`-XX:+UseSerialGC`

## The Parallel GC

Multiple (number of cores by default) threads for young generation GC.
`XX:ParallelGCThreads=number`

If one CPU - default GC is used anyway (even if Parallel GC is requested).
Two CPUs примерно также как default GC.
More than two - можно ожидать уменьшение паузы для young gen GC.

Два варианта:

Parallel Collector также называется Throughput collector.
Типа юзает CPUs чтобы улучшать пропускную способность приложения.

Большая работа должна быть сделана и длинные паузы - норм.
Например, пакетная обработка, куча запросов к БД.

`-XX:+UseParallelGC`

Multiple threaded Young gen GC + Single Threaded old gen GC + compaction.

`-XX:+UseParallelOldGC`

MT for young and for old gens. + compacting.

HotSpot (название JVM) сжимает только old gen.
Young gen в HotSpot рассматривается как копирующий коллектор, так что нет нужды в сжатии.

## Concurrent Mark Sweep (CMS) Collector

Concurrent low pause collector.
Collects tenured gen. Minimizes pause by doing GC work concurrently with the app threads.
Т.е. не останавливает мир ?
Обычно не копирует и не сжимает место.
Если фрагментация становится проблемой - заказывайте кучу побольше.

Для young gen юзает тот же алгоритм что и у Parallel GC.

Юзается для приложений, требующих маленьких пауз, и которые ?могут шарить ресурсы с GC?.
Например Desktop UI, webserver responding to a request or
db responding to quiries.

`XX:+UseConcMarkSweepGC`
and to set the number of threads:
`XX:ParallelCMSThreads=n`

## G1 GC

The Garbage First.
Since Java 7.
Long term replacement for CMS.
It is parallel, concurrent, incrementally compacting low-pause GC.
Имеет другую раскладку, но мы тут объяснять не будем.

`-XX:+UseG1GC`

https://www.youtube.com/watch?v=PA8z44ludgc&ab_channel=SoftTecoTeam

Похоже можно написать свой GC. Есть наверное API для написания GC.

Пропускная способность - отношение общего времени работы к общему времени простоя, вызыванного GC, на длительном промежутке времени.

GC сам потребляет ресурсы.

# 0. Epsilon GC.
Вообще не собирает мусор.
Куча переполняется и приходит OOM Killer.
Может применяться для маленьких приложений, и для сравнения
потерь в производительности другими GC.

# 1. Serial GC.

Eden, S0, S1, Tenure, Permanent.

# 2. Parallel

# 3. Большая сборка

# 4. G1
По умолчанию с 9й JDK.
Изначально позиционировался для больших куч 4Gb+.
* Snapshot At The Beginning (SATB) (как и CMS)
В список живых попадают все объекты, которые были живыми на момент
начала работы алгоритма + созданные во время его работы.
Допускает наличиет "плавающего мусора".

Куча разбита на регионы поколений. Регионов не более 2048.
Группировки по Eden, Survivor, Tenured нет.

5. ZGC

==============

https://www.oracle.com/java/technologies/tuning-garbage-collection-v50-java-virtual-machine.html


https://javarush.com/groups/posts/4075-kofe-breyk-210-vse-tipih-sborjshikov-musora-v-java-o-kotorihkh-vih-dolzhnih-znatjh

heap - куча. Данные приложения.
non-heap - некуча. Программный код и ?другие данные?.
Поколения.
Минорная чистка - только младшее поколение.
Полная чистка - затрагивает оба поколения.
Stop-The-World (STW) пауза.
Все треды приложения остановлены, но оно об этом не знает.

Статья многословная и неточная, не стал продолжать.


