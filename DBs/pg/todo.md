Посмотреть максимальное кол-во коннекшнов в базе pg.

Зачем сервисам больше одного коннекшна ?
Один коннекшн на каждую транзакцию ??

Средства мониторинга pg.





В одном коннекшне может делаться одновременно только один запрос / транзакция ?


cat /etc/postgresql/10/main/postgresql.conf | grep max_connections


(node:6516) MaxListenersExceededWarning: Possible EventEmitter memory leak detected. 11 DB_Checked listeners added. Use emitter.setMaxListeners() to increase limit

psql -c 'select * from pg_stat_activity' > activity.txt

=======

Поискать какие-нить утилиты для мониторинга pg.

