https://docs.docker.com/engine/security/

4 areas of security:

* kernel's support of namespaces and cgroups
* docker daemon
* container config loopholes
* kernel's security features interaction with containers.

# Kernel namespaces

Namespaces: processes in containers cannot see or affect
processes running in another container or host.

Isolated network stack.

Containers on some host like physical machines connected with a common Ethernet switch.

# Control groups

Resources accounting and limiting.

# Docker daemon

Daemon requires root privileges (unless rootless mode is used).

* Only trusted user should control docker daemon.
* Additional attention on a command running from user.
* HTTPS for important endpoints in your API.
* You can also use DOCKER_HOST=ssh://USER@HOST or ssh -L /path/to/docker.sock:/var/run/docker.sock

# Linux

...
