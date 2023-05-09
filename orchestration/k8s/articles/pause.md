https://habr.com/ru/company/southbridge/blog/715402/

Контейнер pause

Регает обрабоотку сигналов.
SIGINT, SIGTERM, SIGCHLD.

Держит namespace.

https://habr.com/ru/companies/southbridge/articles/715402/

kubelet вызывает Runtime Service.RunPodSandbox
интерфейса CIR.

Существует в каждом поде.
От него все контейнеры пода наследуют namespace.

SIGINT, SIGTERM - завершает напрямую.
SIGCHLD - вызывает waitpid.

unshare - запуск в новом namespace.

lsns -

readlink /proc/9932/task/9932/ns/net