В API есть только базовые функции: Выбор сервера, Установка и разрыв соединения, добавление, удаление, обновление, получение объекта и Compare-and-swap.

Время жизни объектов от 1 сек, до бесконечности.

LRU

Работа выглядит так:

Проверяешь есть ли в кэше.
Да - берешь из кэша.
Нет - берешь из базы и заполняешь кэш.

После записи / обновления в БД нужно обновить и кэш.

