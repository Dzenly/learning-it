https://www.youtube.com/watch?v=-yCtBUtTD9o

exporters - посмотреть какие есть.

alert manager

Пром. ходит кудато по ip, port, и берет метрики.

https://www.youtube.com/watch?v=nk3sk1LO7Bo

Есть prometheus query language.
Visualization is weak.

https://habr.com/ru/company/southbridge/blog/455290/

Полностью open source.

Time-Series Database - handles time related data.
Т.е. для каждой записи есть timestamp.
Подразумевается очень большая скорость создания записей - допустим 100к строк в секунду.
В RDB - есть просадка производительности из-за индексации при добавлении больших данных.

В TSDB - все быстрее, но есть data-retention.
Рассчитаны на параллельную работу кучи приложений в одной бд.

===

Извлекает метрики через HTTP вызовы к определенным эндпоинтам,
указанным в конфиге.

Варианты использования:

* Инструментирование приложения - приложение предоставляет совместимые с промом
метрики по заданным url.

* Есть экспортеры.
  Node exporter (Linux машина).
  SQL exporter
  HAProxy Exporter

* Pushgateway
  Как я понял, это когда ты сам суешь данные в пром.

То, что пром умеет полить, позволяет все конфиги писать в одном месте.
И ещё нет зафлуживание пром сервера.

Аггрегирует метрики.
Как я понял событие летит не о каждом 404 событии на сервере, а один раз о кол-ве таких событий за последние 5 мин.

# Инструменты

* Alertmanager
Делаются правила в конфигах. Можно репортить в слак и др. штуки.

* Визуализация. Есть Веб-интерфейс. Можно фильтровать данные.

* Динамическое обнаружение целевых объектов. (Service Discovery)

===

Якобы у Zabbix RDB, поэтому тормозит при больших данных.

Zabbix поддерживает Prometheus формат данных.

Предполагаю, что с помощью diff(5m)}>1 как-то так. Т.Е. изменения за последние 5 минут больше 1
Или на пример nodata(5m) тогда когда появится сработает триггер…
Ответить

usefree
22 ноября 2019 в 16:34
0
используйте комбинацию с функцией absent(metric_name). Она возвращает 1, если метрики нет.

==========

Prometheus служит для хранения обработанной инфы, а не абстрактного текста.

Ключ метрика - значение.

=========

Типы метрик:

* Счетчик:

Кол-во элементов за период времени.

* Измерители
Текущее значение метрики.
Соответственно теряется история изменений.


* Гистограмма
Среднее значение.
Относительные изменения значений.

* Сводка - расширенная гистограма.
Квантили.

=====

# Задания и экземпляры

Экземпляр - веб сервер.

Задание - измерение числа ошибок HTTP на всех инстансах.

# PromQL

* Моментальный вектор. Все метрики по последней метке времени.
* Вектор с диапазоном времени.

# Инструментирование

Добавление клиентских библиотек в приложение. ?? Что за клиенты ??
Есть и для go и для Node.

?? Не понял как работает.

# Экспортеры

* Обычно это образы докер. Легко настраиваются.
Готовый набор метрик и панели мониторинга для быстрой настройки.

Экспортеры БД.
HTTP (HAProxy, Nginx, Apache)
Unix

Можно конвертировать форматы с помощью экспортеров.

# Оповещения

Можно в слак, можно хоть куда.

















