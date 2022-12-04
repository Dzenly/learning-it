# Big Bang / Rebuild

Shutdown, update, start new.

# Blue Green

Green works.
Blue deploys then finish last user reguests in green and switch new to blue.
But green does still work for failover.

## Problems

* double infrastructure
* rolling back is complex task.

# Rolling updates

One new instance up, one old instance down.

* Should be good healthchecks.

# Canary

Сколько-то процентов направляется на новый инстанс.
Some tests or metrics for v2.

# References

https://www.youtube.com/watch?v=HKkhD6nokC8&t=12s&ab_channel=DevOpsToolkit

