https://iximiuz.com/en/posts/journey-from-containerization-to-orchestration-and-beyond/

# Runtimes:
runc, cri-o, containerd

Low Level container runtime is piece of software that takes as an input:
* folder containing rootfs
* container cfg file (resource limits, mount points, process to start, etc.)

As a result runtime support isolated process (container, workload).

Often *workload* is represented by a container.

========

As of 2019 - the most widely used container runtime is *runc*.
Written in golang as a part of Docker.

But become self-sufficient CLI tool.

It is reference implementation of OCI runtime spec.

=====

Now containerd is self sufficient piece of software.

runc - cmd line tool.
containerd - long-living daemon.

# containerd

uses *runc* and another utilities.

Responsible for pull/push, store images locally, etc.
cross-container network management.

=======

Low level runtime plugins support - containerd-shim.

=======

# cri-o

Container Runtime Interface OCI-based.
Open Container Initiative.

For kub.

also daemon.


==========


Kuber

Dockershim / CRI module

============

# podman

*libpod*, not daemon.
to manage: images, container lifecycles, pods (groups of containers).

podman is cli tool on top of libpod.

low level - runc.

?? Planning to get rid of runc ??

Claims compatibility with docker cli api.









