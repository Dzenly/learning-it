https://kubernetes.io/docs/concepts/overview/

Open source
For managing *containerized* workloads and services.

From Greek Рулевой или Пилот.

Google, open-sources in 2014.

Provides
* *Service discovery and load balancing*
Can expose a container using the DNS name or IP.

* *Storage orchestration*
Allows you to auto-mount a storage system: local storages, public cloud providers, etc.

* *Automated rollouts and rollbacks*
You can describe desired state and change the current state to the desired one.

* *Automatic bin packing*
You provide Kubernenes with a cluster of nodes that it can use to run containerized tasks. And quotes.

* *Self healing*
Restarts, replacements, probes.

* *Secret and configuration management*
Passwords, OATH tokens, SSH keys, etc.

Only containers, but not hardware level.

But it provides logging, monitoring and alerting (PoC).

Does not limit the types of applications supported.
Stateful is supported.

**What about PG cluster in k8s** ?

Provides declarative API.

# Kuber are not

* Not a platform for app building.
* Not a framework or library.
* No logging, monitoring, alerting.


# Components

Кластер, узлы.
Как минимум 1 воркер нода.

Компоненты управления могут быть запущены на любой машине в кластере.
Но обычно все компоненты управления заливаются на один комп, и на нем
не запускаются пользовательские поды.

## *API-Server* - Может скалироваться горизонтально. Front end for k8s control plane.

## *etcd* - key-value store for all cluster data. You need backup it.

## *scheduler* - Selects nodes for newly created pods taking into account required resources, affinity, anti-affinity.

## *kube-controller-manager* -
* node controller (noticing and responding when nodes go down)
* Job controller: Разовые задачи по созданию подов и отслеживанию их работы до завершения?
* EndpointSlice controller: Link between Services and Pods
* ServiceAccount controller: Default ServiceAccounts for new namespaces (токены и аккаунты).

#cloud-controller-manager

Lets you link your cluster into your cloud privider's API.

* *Node Controller*.
* *Route Controller*
* *Service Controller* (Load Balancers)

# Node Components

## kubelet

Does not manage containers which are not created by K8s.

## kube-proxy

Implementing part of *Service* concept.
Maintains network rules on nodes.
Uses OS packet filtering if exist, otherwise kube-proxy forwards the traffic itself.

## Container runtime


=======================

# Addons

DaemonSet, Deployment.

## DNS
ClusterDNS
Containers automatically include this DNS server in their DNS searches.

## Web UI
For troubleshooting cluster and apps.

## Container Resource Monitoring
Metrics and UI.

## Cluster-level logging
Central log store with search interface.













