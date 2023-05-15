https://www.youtube.com/watch?v=0i1nO9gwACY

github.com/gperftools/gperftools.

GOGC=off - отключить GC.

systemtap

Якобы все переменные передаются через stack.
И возвращаются тоже.

perf_events

valgrind не работает.
Т.е. GO использует свои аллокаторы, и там работает GC.


pprof

go tool pprof -inuse_space

Лучше юзать специализированные ф-и для вывода, типа writeString, чем общие,
берущие на вход интегрфейс, типа printf.

Оптимизаторы постоянно совершенствуются.
Старые статьи по оптимизации могут быть бесполезны.

Есть пакет unsafe.

Есть reflect.

Go RT умеет записывать собственный трейсинг.

runtime trace go.

_ символ - как-то влияет на импорт пакета.
Наверное, ничего не присваивает.


# Conlusion

CPU profiler
Memory profiler
All allocations tracing
Escape analysis
Lock/Contention profiler
Scheduler tracing
Tracing
GC tracing
Real time memory statistics
System profilers like perf and systemtap.
But no tool will replace deep understanding of how your program works from start to finish.


