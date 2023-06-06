https://www.youtube.com/watch?v=kKigibHrV5I&ab_channel=JPoint%2CJoker%D0%B8JUGru

`pmap -x PID`

`java -XX:NativeMemoryTracking=[summary|detail]`

Статистика поедает 5-10% производительности.
+2 words / malloc

Аллокации только внутри JVM.

Ты ограничил память на Javа, но GC хочет памяти тоже.

OpenJDK 11. Heap size 2 GB
GC    Overhead, MB, %
Serial         7  0.3
Shenandoah    36  1.8
Parallel      86  4.2
CMS          141  6.9
G1           165  8.1
Z            206 10.1

`-XX:+AlwaysPreTouch` - чтобы OS не экономила выделение, с сразу дала все, что просим.

Heap может стать и ниже -Xms.

jmap
jcmd PID GC.class_stats
jcmd PID VM.metaspace





