https://www.youtube.com/watch?v=yg_G0vnYdhU

небуферизованный канал блокируется после записи, типа считается, что весь буфер забит.

нужно чтобы кто-то прочитал.






===========================================

http://dmitryvorobev.blogspot.ru/2016/08/golang-channels-implementation.html




===========================================


https://habrahabr.ru/post/308070/

Буффер + флаги.

recvq - очередь горутин, ожидающих чтения из канала.
sendq - очередь горутин, ожидающих запись в канал.

lock - mutex.

?? что за lock-free операции при неблокирующих вызовах ??

Допустим, есть два писателя и один читатель.

Если читатель тупо возьмет из буфера, то блокировка на писателе останется.

В итоге читатель читает из буфера, дальше срабатывает писатель, и удаляется из очереди.




# Синхронные каналы (не буферизуются).

При записи в кала проверяется очередь читателей,
данные записываются в стек ожидателя, и ожидатель разблокируется.

?? А если читателей несколько??
Получит только первый ??


# Асинхронные - буферизуются.

Если буфер полный - запись блокируется и сендер записывается в очередь.

Каналы работают по принципу FIFO.

Допустим две горутины пишут, одна читает.
Допустим. одна заблокирована на чтение, и одна записала.

Читатель прочитает, 

==================================================

https://golang.org/ref/spec#Channel_types

При определении канала можно задавать на запись он, на чтение, или двунаправленный.
Это делается с помощью <-.


==================================================

https://golang.org/doc/effective_go.html#channels





==================================================

https://docs.google.com/document/d/1yIAYmbvL3JxOKOjuCyon7JhW4cSv1wy5hC0ApeGMV9s/pub

# Есть три типа каналов.


==================================================




