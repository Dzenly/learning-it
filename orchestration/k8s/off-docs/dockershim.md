https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/check-if-dockershim-removal-affects-you/

Kuber создал адаптер dockershim, т.к. Docker появился до спецификации CRI.

А сейчас обращается напрямую к containerd.

Поэтому например, эти контейнеры невидимы для docker.
Соответственно никаких docker logs, docker ps и т.д.


https://kubernetes.io/blog/2020/12/02/dockershim-faq/


