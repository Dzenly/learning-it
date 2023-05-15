https://doc.traefik.io/traefik/observability/logs/

By default - stdout.

```yaml
# Writing Logs to a File
log:
  filePath: "/path/to/traefik.log"
  format: json | common
  level: DEBUG, PANIC, FATAL, ERROR, WARN, INFO.
```

USR1 signal is supported


https://doc.traefik.io/traefik/observability/access-logs/

To enable the access logs:

```yaml
accessLog: {}
```
filePath
format

bufferingSize


# Filtering

* statusCodes (range)
* retryAttempts
* minDuration (if longer then pointed)

```yaml
# Configuring Multiple Filters
accessLog:
  filePath: "/path/to/access.log"
  format: json
  filters:    
    statusCodes:
      - "200"
      - "300-302"
    retryAttempts: true
    minDuration: "10ms"
```

https://doc.traefik.io/traefik/observability/metrics/overview/

To enable metrics:
```yaml
metrics: {}
```

```yaml
metrics:
  prometheus:
    buckets:
      - 0.1
      - 0.3
      - 1.2
      - 5.0
```
addEntryPointsLabels - enable metrics for entryPoints.

addServicesLabels - enable metrics for services.

entryPoint - entrypoint to expose metrics.

=============

https://doc.traefik.io/traefik/observability/tracing/overview/

Visualize Requests Flow





