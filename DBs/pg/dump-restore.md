https://www.postgresql.org/docs/9.5/static/app-pgdump.html

Дампит только одну базу.
А пользователь ??
Или старые пользователи остаются?

На выходе может быть скрипт, а может архив.

psql может съедать текстовый скрипт.

pg_restore - съедает архив.

-Fc - Custom Format.

-c clean (only meaningful for text format, cause pg_restore has such an option)
-f file to output

--if-exists - works with -c.


-C - drop and create db.
Тоже имеет смысл только для plain text.

-Z 9

Можно сделать текстовый формат с компрессией.

-d dbname
Эквивалентно первому неопциональному аргументу.

-h host

-p port

-U username

-w
no password.
Пароль должен быть в .pgpass file.
?? а переменная окружения?

PGPASSWORD="pxtm0222" psql -h localhost -U rvision rvision

## Environment variables.

PGDATABASE

PGHOST

PGOPTIONS
PGPORT
PGUSER

Также юзаются многие переменные отсюда:

https://www.postgresql.org/docs/9.5/static/libpq-envars.html

PGHOSTADDR
PGPASSFILE

https://www.postgresql.org/docs/9.5/static/libpq-pgpass.html

~/.pgpass либо задается PGPASSFILE

hostname:port:database:username:password

---------------

# Примеры:

pg_dump -Fc mydb > db.dump



https://www.postgresql.org/docs/9.5/static/app-pg-dumpall.html

Дампит целый кластер, с базами, схемами, юзерами.

# https://www.postgresql.org/docs/9.5/static/app-pgrestore.html

Два режима:

Если задашь базу данных - pg_restore коннектится к базе и восстанавливает её.
Иначе создается скрипт и записывается в файл или в stdout.
Формат скрипта аналогичен plain text for pg_dump.

-c (clean) --if-exists -C (create)

Если юзается -С - начальная база будет указанная в команде будет юзаться только для
посылки команд DROP DATABASE / CREATE DATABASE.

А настоящее имя базы возьмется из архива.

?? А что если старой базы нет ?? Нужно ли задавать -d имя базы ??
там какие-то connection-option.

Ну вот похоже, нужно что-то делать со скриптом, если не задаешь имя базы.
Наверное, лучше задавать.
Типа пререквизит - старая база.


-h host
-p port
-U username
-w - no password

Env vars:

PGHOST
PGOPTIONS
PGPORT
PGUSER

## Examples

pg_dump -Fc mydb > db.dump

### drop and re-create.

dropdb mydb
pg_restore -c --if-exists -C -d postgres db.dump
Т.е. можно любое существующее имя бд.




















