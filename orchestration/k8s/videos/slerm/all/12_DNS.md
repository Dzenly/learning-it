https://www.youtube.com/watch?v=MLp8_qVLkzc&list=PL8D2P0ruohOA4Y9LQoTttfSgsRwUGWpu6&index=14

Из пода делается DNS запрос.

Node Local DNS (DaemonSet) - кэширующий DNS сервер (может иметь адрес, например 169.254.25.10).
По умолчанию вроде не стоит.

Если там записи нет, NodeLocalDNS идет в CoreDNS.

У NAT в линукс есть проблема с потерей пакетов?

CoreDNS стоит за абстракцией ClusterIP.

Кэширующий DNS общается с Core DNS по TCP.
(или можно апнуть)

`k get all -n kube-system | grep dns`

Kubelet

`cat /etc/kubernetes/kubelet.env | grep dns`
> -cluster-dns=169.254.25.10

`cat /etc/resolv.conf`
> nameserver 169.254.25.10
> search default.svc.slurm.io svc.slurm.io slurm.io
> options ndots:5 - внешний запрос не менее 5 точек.

DNS запись для сервиса - service_name.namespace.svc.cluster_domain_name

tcpdump -n -p -i eth0 port 53

search - лишние запросы, если запрос наружу.
в coredns - есть configMap.
Ну либо всех заставлять использовать адреса с точкой.

Есть плагин в coreDNS autopath.

===========

# Способы публикации.

По умолчанию к поду не обратишься из вне.
А через сервисы и ингресы.

Services - L3/L4.

* ClusterIP - взаимодействие сервисов внутри. Можно через k proxy или через k port-forward.

* NodePort
Большой порт на локальном хосте - пробрасывается в сервер.

* LoadBalancer (обычно в облаках, с контроллером облака)

* ExternalName
externalName: my.database.example.com

* ExternalIPs
Вместо порта - IP.
На всех серверах создается правило перенаправления.

* Headless
Имя есть, а адреса нет.
DNS записи содержат все поды, которые стоят за этим сервисом.

=====

Ingress - L7.

Реверс-прокси.

annotations - передача параметров.

Сниппеты.

=====

Cert-manager
Автоматическое получение сертификатов для серверов.
Можно через LetsEncrypt, можно самоподписанные выпускать.
Работает с OpenShift тоже.
Хранит, продлевает сертификаты.
Custom Resource Definitions (CRD)

Issuer - Ишьюер для неймспейса.

ClusterIssuer - Для всего кластера.

Certificate - (домен, подпись, как будто это просто CSR).

Order, Challenge - способ валидации нашего домена.

RBAC

============

`html repo add jetstack https://charts.jetstack.io`

```sh
helm install \
--namespace cert-manager \
--version v0.15.1 \
#--set installCRDs=true
```

Валидации:

http01 - создание урла с токеном. Чисто на момента валидации.

dns01 - txt запись. Которую проверяет issuer.

```
annotations:
 certmanager.k8s.io/cluster-issuer: letsencrypt
```

Если приложение работает по TCP. То не ингресс.
Просто потому что многие http сервера ингресса
плохо умеют в TCP.


























