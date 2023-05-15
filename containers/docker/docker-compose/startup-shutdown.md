https://docs.docker.com/compose/startup-order/

* depends_on
* links
* volumes
* network_mode

Compose does not wait for container ready.

Reason: app must be resilient to temporary breaks.

There are tools:

* https://github.com/vishnubob/wait-for-it
* https://github.com/jwilder/dockerize
* https://github.com/Eficode/wait-for







