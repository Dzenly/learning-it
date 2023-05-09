# HTTP 0.9 (1989, 1 Page RFC)

# HTTP 1.0 (1996, 63 Page RFC)

New connection for each request/response.

# HTTP 1.1 (1997? 1999)

https://stackoverflow.com/questions/246859/http-1-0-vs-1-1
https://greenbytes.de/tech/webdav/rfc2616.html#rfc.section.19.6.1

## Required *Host* header.
Для использования в прокси серверах.
И для поддержки множества сайтов на одном сервере.

## Persistent connections
One connection for several req/rep.
Хотя через расширение он был возможен и в 1.0.

## OPTIONS method

Посмотреть возможности сервера. В основном для CORS.

## Caching

HTTP 1.0: If-Modified-Since

HTTP 1.1: Entity Tag, Conditional headers (If-Unmodified-Since, If-None-Match, Cache-Control)

## New Return Code

100 - Continue
Answer for headers, to allow client to continue.
(Checking for size limits or authorization issues).

### Etc

Digest authentication and proxy authentication
Extra new status codes
Chunked transfer encoding
Connection header
Enhanced compression support
Much much more.


# SPDY (2009)

# HTTP2 (2015) (20й год - 44% сайтов на HTTP2)

https://www.8host.com/blog/v-chem-raznica-mezhdu-http1-1-i-http2/

На 19й год. HTTP2 поддерживали треть веб-сайтов в мире.

Сжатие, мультиплексирование, приоритезация.
Двоичный уровень кадрирования.

https://vc.ru/seo/442112-http-2-chto-eto-i-zachem-on-vam

https://www.youtube.com/watch?v=SZHpnohrbIQ

*Бинарный протокол* А не текстовый, как в предыдущих версиях.
Уменьшает размер сообщений.
Сжатие из коробки.
*Frame* - Каждое HTTP Message состоит из фреймов.
* Length (24)
* Type (8), Flags (8)
* Stream Identifier (31)
* Payload (0+)

Type
Data
Headers
Priority
RST_STREAM
Settings
Push_Promise
Ping
GoAway
Window_Update
Continuation

Stream - поток фреймов с одинаковым Stream ID.
Может быть несколько стримов в одном соединении.

Упрощение по сравнению с текстовым форматом.
Т.к. там всякие white-spaces.
А во фреймах все жестко.

В HTTP1.1 для того чтобы запросы делать одновременно - нужно
было открывать новые соединения.
Т.к. нельзя отправить новый запрос до получения ответа на предыдущий.

HTTP2 для параллелизации запросов создает новые стримы в рамках
одного соединения. Это называется мультиплексирование.

Server Push
Принудидельное заполнение кэшей клиента.

https://www.youtube.com/watch?v=QgK6-8zCnQM&t=4s

* Бинарный.
* Честный мультиплексинг.
* Приоритизация - можно управлять сервером с клиента, типа вот этот запрос важнее.
* Компрессия хедеров (помогает например, ускорять пересылку куков)
* Server Push (Предзаполнение кэша)
* Отмена загрузки файлов.

# HTTP3

https://www.youtube.com/watch?v=ai8cf0hZ9cQ

QUIC

UDP и перепосылка битых данных.
Нет возни с sequence number, и рукопожатиями.

Encryption by default.

https://datatracker.ietf.org/doc/rfc9114/

# HTTP3 (20й год - 5% сайтов)

https://www.youtube.com/watch?v=T_4xgLUJFF0

Джиттер - фазовое дрожание сигнала.

head-of-line blocking.
ОТправляешь несколько файлов, во всех кроме одного все ок, но ты их не можешь считать, пока не придет потерянный пакет этого одного.

bufferbloat
Канал забит, и высокоприоритетные запросы не проходят.

IP Migration. Стрим ID, вместо IP.

Есть вариант работы HTTP2 через QUIC.

Есть модуль на Rust, который поддерживает реализацию QUIC.

На Node.js реализация тоже есть! )

## Критика

* user space (а не kernel space)
* UDP security.


Если не юзаются беспроводные сети - QUIC может быть медленнее HTTP2.
И м.б. даже медленнее HTTP 1.1.
Т.к. в этих сетях есть оптимизация на уровне железа. А QUIC это прикладной уровень.

https://www.youtube.com/watch?v=XwdCL_YjJMo

Вообще классная лекция:
https://www.youtube.com/watch?v=_QQX0Ezpq8U

