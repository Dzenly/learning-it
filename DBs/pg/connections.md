https://wiki.postgresql.org/wiki/Number_Of_Database_Connections

Можно поддержать большую конкурренцию, если юзать пул коннекшнов.

Если съели все ресурсы - добавлять коннекшны смысла не имеет.

Хорошо бы использовать очереди.

Возможно оставлять запрос на транзакцию в очереди, и освобождать коннекшн, интересно, а как тогда получать результаты?

=========

Почему connection pooler не включили в PG server:

* Круто когда он работает на отдельной машине. ?? фиг знает почему.
* Типа гибче можно настраивать всякие стратегии пулинга.
* 


150 000
780 - на сундуках.

https://stackoverflow.com/questions/32449474/knex-js-with-pgbouncer


```
20|response-playbooks  | 2018-08-31 14:53:42: verbose: [RP-runPlaybooks] runPlannedAction: Done — incident id: 1248, table type: scripts
24|Collector.js        | 2018-08-31 14:53:42: error: Error: read ECONNRESET
24|Collector.js        |     at _errnoException (util.js:1024:11)
24|Collector.js        |     at TCP.onread (net.js:615:25) 
24|Collector.js        | FILE: /opt/collectorjs/index.js:299
6|am                   | 2018-08-31 14:53:42: verbose: [AM.server] collector.launchScript - request: #739 375 ms
6|am                   | verbose: [AM.server] collector.launchScript - request: #767 3.3 s
6|am                   | verbose: [AM.server] collector.launchScript - request: #952 3.3 s
6|am                   | 2018-08-31 14:53:42: verbose: [AM.server] collector.launchScript - request: #668 3.19 s
6|am                   | 2018-08-31 14:53:42: verbose: [AM.server] collector.launchScript - request: #252 3.19 s
6|am                   | 2018-08-31 14:53:42: verbose: [AM.server] collector.launchScript - request: #914 2.88 s
20|response-playbooks  | 2018-08-31 14:53:42: error: [RP-runPlaybooks] Error: read ECONNRESET
20|response-playbooks  |     at /opt/smp/services/am/models/methods/collector/utils/task.js:32:44
20|response-playbooks  |     at bound (domain.js:301:14)
20|response-playbooks  |     at runBound (domain.js:314:12)
```

```
2018-08-31 14:53:42: .[31merror.[39m: Error: read ECONNRESET
    at _errnoException (util.js:1024:11)
    at TCP.onread (net.js:615:25)
FILE: /opt/collectorjs/index.js:299
```
