https://www.youtube.com/watch?v=fUBpMbHsfL4&list=PL8D2P0ruohOA4Y9LQoTttfSgsRwUGWpu6&index=13

Job выполняется один раз.
Настройка окружения.
Например, создал БД.

activeDeadLineSeconds

backoffLimit - кол-во попыток (есть баг что иногда +1).

Джобы надо удалять руками ?
Т.е. весят completed контейнеры.
Если много - кубер кластеру плохо. Т.к. докеру плохо на узлах.

SIGTERM
grafulShutdownPeriod
SIGKILL (статус становится Terminating, и приходит GC)

`restartPolicy: Never` - обязательно.

По умолчанию куб перезапускает любой упавший в поде контейнер.

======

CronJob

```yaml
schedule: "*/1 * * * "
concurrencyPolicy: Allow (Forbid, Replace)
```

k get cronjobs.batch

k get job
k get pod

successfulJobsHistoryLimit

startingDeadlineSeconds

Контроллер кронджобов если видит что проканал
сколько-то запусков - запустит их впараллель.

Кронджоб 2 года назад был весьма коряв.
Рекомендуют юзать только Forbid.

Джобы должны быть идемпотентные.

Самое простое забить на кронджобы, -
и юзать простой под с обычным кроном внутри.

===============

# RBAC

## ServiceAccount
У кубера нет пользователей?

get secret user-token-ghl52 -o yaml

Выдаст
ca.crt - корневой сертификат нашего кластера?

token: - к нашему сервис аккаунту.

k describe user-token...
Тут будет раскодированный вариант.

С этим токеном можно авторизоваться в API сервере Куба.

Токен есть волюмом во всех наших контейнерах.
И если приложению надо взаимодействовать с API,
оно читает этот токен и взаимодействует.

Если сервис аккаунтов не указывать.
То подключается дефолтный с минимальными правами.

В деплойменте можно указывать сервис-аккаунт.

`k -n namespace_name get roles`

rules:
Что можно что нельзя.

Примеры запросов

`GET /apis/networking.k8s.io/v1beta1/namespaces/{namespace}/ingresses/{name}`

`GET /api/v1/namespaces/{namespace}/pods/{name}/log`

verbs - действия.

Есть автосгенеренные доки на комментах из сорцов.
Там часто больше инфы чем в официальных доках.

RoleBinding - связь между Role и ServiceAccount

subjects -

========

## ClusterRole/ClusterRoleBinding

Действует на весь кластер, а не на неймспейс.

view, edit, cluster-admin, admin

Можно указывать кластерные роли (ClusterRole) в биндингах для неймспейса (RoleBinding).
Типа тогда они будут действовать на этот неймспейс.

=======

## Внешний сервер авторизации для API сервера.

И можно биндить на юзера и группу из этих внешних средств
авторизации.

=======

Есть режим авторизации по сертификатам.

=======

Звездочка - можно все.

`k get service --as=system:sirviceaccount:default:user`

=====












===============






Role
RoleBinding
ClusterRole
ClusterRoleBinding

















