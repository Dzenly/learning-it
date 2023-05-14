https://www.youtube.com/watch?v=LLVfC08UVqY&list=PL8D2P0ruohOBSA_CDqJLflJ8FLJNe26K-&index=3

ReplicaSet vs Deployments

selectors/labels

ReplicaSet отличается от Pod тремя параметрами:
* replicas
*
```yaml
selector:
  matchLabels:
    app: my-app
template:
  metadata:
    labels:
      app: my-app
  spec:
    containers:
      - image: somepath/nginx:1.12
        name: nginx
        ports:
          - contaienrPort: 80
```

`k delete all --all -A` (удалить вообще все, это как в системе
запустить `rm -rf /`)

create (создается первый раз) vs apply (применяет изменения)

kubectl get rs (replicasets)
po - pods

Когда нода возвращается - может стать подов больше чем надо.

kubectl describe

*replicaset не умеет обновлять образы в приложениях*

Pod и ReplicaSet - скорее служебные абстракции.
Deployment - уже юзабельная.

kubectl explain - получить хелп по полям объекта куба.

Deployment - набор полей в spec не отличается от ReplicaSet.

`k rollout undo`

`k rollout history`

`k explain deployment.spec.strategy`
rollingUpdate vs Recreate

```yaml
maxSurge: 20%
maxUnavailable: 20%
```
Можно в штуках, можно в процентах.

====

====

# namespaces

Чтобы не повторялись имена.

Есть claster wide объекты.
Storage Class например. PV. Cluster roles.

Политики взаимной видимости.

====

# Resources

* limits - когда убивать или не больши скольки давать.
* requests - влияет на распределение подов по кластеру.

cpu - 100m milliCPU (одна десятая одного ядра)
memory: 100Mi

Mi- это точно 1024 * 1024

Capacity пода.

Ты можешь ошибиться и дать поду сильно много.
Столько ему не надо, но он будет занимать ноду.

====

# QoS
* Best Effort
* Burstable
* Если указаны конкретные ресурсы - это высший QoS класс.

Если лимиты равны реквестам - хорошо.

====

`k patch ...`

====

k describe



====

====


