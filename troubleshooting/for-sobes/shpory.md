# network

sudo apt-get install iptraf -y
iptraf

https://linuxhint.com/network_usage_per_process/


# ps

Top 10 processes.

ps -eo pid,user,ppid,cmd,%mem,%cpu --sort=-%cpu | head


# PG

```
select schemaname as table_schema,
    relname as table_name,
    pg_size_pretty(pg_total_relation_size(relid)) as total_size,
    pg_size_pretty(pg_relation_size(relid)) as data_size,
    pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid))
      as external_size
from pg_catalog.pg_statio_user_tables
order by pg_total_relation_size(relid) desc,
         pg_relation_size(relid) desc
limit 10;
```


# wireshark

https://habr.com/ru/articles/436226/

# tcpdump

https://www.dmosk.ru/miniinstruktions.php?mini=tcpdump-cmd

tcpdump -i eth0
tcpdump src 94.19.179.142
tcpdump dst 94.19.179.142
tcpdump port 80

# timedatectl

https://selectel.ru/blog/upravlenie-loggirovaniem-v-systemd/

# journalctl

systemctl status postgresql
journalctl -u nginx.service
journalctl /usr/bin/docker

https://habr.com/ru/companies/ruvds/articles/533918/

journalctl -b - логи с момента загрузки системы.
journalctl ---since yesterday
journalctl -p err -b

0 — EMERG (система неработоспособна);
1 — ALERT (требуется немедленное вмешательство);
2 — CRIT (критическое состояние);
3 — ERR (ошибка);
4 — WARNING (предупреждение);
5 — NOTICE (всё нормально, но следует обратить внимание);
6 — INFO (информационное сообщение);
7 —DEBUG (отложенная печать).

# dmesg

Кольцевой буфер. Проблемы с драйверами.

# Изменение размера диска на Ext4

диск какой - mbr или gpt ?
если последний, то разделы смотреть через

kpartx /dev/sda
по размеру находим свою партицию и ее номер в таблице партиций

 kpartx /dev/sda
sda1 : 0 2048 /dev/sda 2048
sda2 : 0 1048576 /dev/sda 4096
sda3 : 0 124776414 /dev/sda 1052672
у нас это номер 3

увеличиваем партицию с помощью growpart

growpart /dev/sda 3
в выводе команды, покажет насколько выросла (если есть куда расти)

далее увеличиваем физикал волюм в lvm, размещенном на этой партиции -

pvresize /dev/sda3
увеличиваем логический диск на этом волюме

lvextend -l +100%FREE /dev/mapper/centos-root
ну а если фс на логическом волюме xfs, то увеличиваем и ее

xfs_growfs /dev/mapper/centos-root
lvm-команды, должны присутствовать в ОС, остальные - не факт, нужно будет поставить

===========================

Как работать с jaeger или tempo.
Как работать с grafana-loki или ELK.

Как читать разные журналы:
Redis, Nginx, PG, Kafka, RabbitMQ, ClickHouse
Системные журналы линукс.
Журналы сетевых устройств.
traceroute - научиться понимать до куда доходят пакеты.
А в каком месте - теряются.