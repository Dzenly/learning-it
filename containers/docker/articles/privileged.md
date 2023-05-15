https://phoenixnap.com/kb/docker-privileged#:~:text=option%20for%20you.-,What%20is%20Docker%20Privileged%20Mode%3F,App%20Arm%20and%20SELinux%20configurations.

Root capabilities to all devices on the host system.
E.g. allows to modify App Arm and SELinux Configurations.

?? Why dind requires priveleged mode ?

docker inspect --format='{{.HostConfig.Privileged}}' [container_id]
true/false


user remapping.
dockermap user and group.
/etc/subuid
/etc/subgid

https://www.trendmicro.com/en_us/research/19/l/why-running-a-privileged-container-in-docker-is-a-bad-idea.html

Container has all root capabilities on host.

DinD or Direct hardware access.

===

By default docker daemon runs as root.
Creating another user is highly recommended.


Common containers have limited capabilities.
But priveleged has all of them.

# Attacks

* Put ssh key to /root/authorized_keys
Mount /mnt as root, then create `/mnt/root/.ssh/authorized_keys.`


* Any other manipulation with disks.

* cgroups notify_on_release and release_agent to spawn shell within the host root.

* Deploying custom kernel module (reverse shell)

# Recommendations for privileged containers

Rootles mode does not allow:
* Cgroups (including docker top, which depends on cgroups)
* AppArmor
* Checkpoint
* Overlay network
* Exposing SCTP ports.

==

Encrypt network connections.






https://twpower.github.io/178-run-container-as-privileged-mode-en



https://snyk.io/blog/privileged-docker-containers






https://containerjournal.com/topics/container-security/why-running-a-privileged-container-is-not-a-good-idea/



