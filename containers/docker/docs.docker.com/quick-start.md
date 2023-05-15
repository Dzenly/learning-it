https://docs.docker.com/get-started/

Containers apply aggressive constraints an isolations.
So they are secure.

Контейнер работает с изолированной файловой системой.

Kuber and Swarm are tools for orchestration.

Docker desktop (windows, osx)
оркестрация без кластера.

# Kubernetes

Pod config for kuber:

```
apiVersion: v1
kind: Pod
metadata:
  name: demo
spec:
  containers:
  - name: testpod
    image: alpine:3.5
    command: ["ping", "8.8.8.8"]
```

kubectl apply -f pod.yaml
kubectl get pods
kubectl logs demo
kubectl delete -f pod.yaml

# Swarm

docker swarm init
docker service create --name demo alpine:3.5 ping 8.8.8.8
docker service ps demo
docker service logs demo
docker service rm demo

https://docs.docker.com/get-started/part2/

Dockerfile - определяет как собрать приватную FS для контейнера и содержит метаданные, описывающие
как запускать контейнер.








