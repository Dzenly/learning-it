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

k rollout history

`k explain deployment.spec.strategy`

```yaml
maxSurge: 20%
maxUnavailable: 20%
```
====

# namespaces

====

# Resources

* limits
* requests - влияет на распределение подов по кластеру.

cpu - 100m milliCPU (одна десятая одного ядра)
memory: 100Mi

====

# QoS
* Best Effort
* Burstable
*

====

`k patch ...`

====



====

====














