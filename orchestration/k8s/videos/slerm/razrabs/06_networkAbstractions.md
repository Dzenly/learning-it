https://www.youtube.com/watch?v=OmTYdf_uDeQ&list=PL8D2P0ruohOBSA_CDqJLflJ8FLJNe26K-&index=6&ab_channel=%D0%A1%D0%BB%D1%91%D1%80%D0%BC

# Пробы.

## readiness - не ставится в балансировку, пока не станет true.

httpGet (200-399)
exec
tcpsocket

periodSeconds
successThreshold
timeoutSeconds

======

## liveness
...
+initialDelaySeconds

======

# startup

failureThreshold: 30
periodSeconds: 10

======

# Публикация
Сервис vs Ingress

## Сервис

### **ClusterIP**

Селектор должен совпадать с лейблами тех подов, на которые
нужно балансировать трафик.

Поды и Сервис должны быть в одном неймспейсе.
Но мы можем обратиться к Сервису из другого неймспейса.

IP адрес пода может смениться при рестарте пода.

kubectl proxy - средства проброса нашего приложения наружу.
Но устарело.

`k port-forward service/my-service 10000:80`

Например, для локальной разработки.

### NodePort

type: NodePort

### LoadBalancer (основан на NodePort)
Обычно в облаках.

### External Name

Параметризация внешнего адреса.

### ExternalIPs

Трафик, приходящий на множество IP, прокидывается в наши Поды.

```yaml
kind: Service

spec:
  ...
  externalIPs:
    - 80.11.12.10
```

### Headless

ClusterIP: none

Можно по nslookup my-service
получить список подов.
Это может применяться для stateful sets.

=================

Пулы адресов для сервисов и для подов - непересекающиеся.

`k get pod --show-labels`

Сервис по лейблам понимает что это сервисы его.

IP адрес сервиса - сработает.

Но можно и `curl my-service.my-namespace`.

`k get svc`

LoadBalancer вне кластера?
Соответственно добавляется NodePort.

===============

Service  это либо IPTABLES
либо IPVS (IP Virtual Server).

IPTABLES - создан для файрволов и основн на списках правил в ядре, IPVS - для балансировки и основан на хэш-таблицах в ядре и поддерживает более продвинутые балансировки, чем IPTABLES.
Типа лучше и по латентности и по пропускной способности.

===============

# Ingress

Сервисы не очень удобны для взаимодействия из вне.

Ingress Controller - например, некий nginx, который перенаправляет запросы в наше приложение.

```yml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    ...
spec:
  rules:
    - host: foo.mydomain.com
    http:
      paths:
        - pathType: Prefix
          path: "/"
          backend:
            service:
              name: my-service
              port:
                number: 80
```

Контроллер использует сервис только чтобы выдернуть IP
подов.

# Аннотации.
Управление сущностями.
Например Ingress Controller.
https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/
Можно внести кастомный сниппет.
https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#server-snippet









