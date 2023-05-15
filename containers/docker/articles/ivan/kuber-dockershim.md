https://www.mirantis.com/blog/mirantis-to-take-over-support-of-kubernetes-dockershim-2/

* Storage volumes
* Networks
* Clouds support


Now:
* CRI (container runtime interface)
* CNI (container network interface)
* CSI (container storage interface)

====

Docker - does not complain these standards, so there is wrapper - shim.

Dockershim translates CRI commands to Docker Engine commands.

=======

Docker images are compatible with OCI.

containerd is CRI compliant.

========

Otherwise, if you’re using the open source Docker Engine, the dockershim project will
be available as an open source component,
and you will be able to continue to use it with Kubernetes;
it will just require a small configuration change, which we will document.

https://kubesphere.io/blogs/dockershim-out-of-kubernetes/#:~:text=Dockershim%20was%20a%20temporary%20solution,serve%20as%20its%20container%20runtime.&text=Currently%2C%20the%20KubeSphere%20container%20platform,supports%20any%20CRI%2Dcompliant%20implementations.

Dockershim - tmp solution provided by Kubernetes community.



