https://prometheus.io/docs/prometheus/latest/configuration/configuration/

Кое что конфигурится cmd line флагами:
* Расположение данных.
* Макс кол-во данных на диске и в памяти.
* ...

=====

Кое-что конфиг файлом.
* Everything related to scraping.

SIGHUP to reload cfg.

HTTP POST /-/reload (when --web.enable-lifecycle)

```
global

  scrape_interval
  scrape_timeout

  evaluation_interval (how often to evaluate rules)

  external_labels: (labels to add to any time series or alerts when communicating with external systems (e.g. alertmanager))
    labelname: labelvalue

rule_files:
  - filepath_glob

scrape_configs:
 ...

alerting:

remote_write:

remote_read:

```

https://prometheus.io/docs/prometheus/latest/configuration/configuration/#%3Cscrape_config%3E

In general - one scrape cfg - one job.

Statically configured by static_configs, or dynamically discovered
using service-discovery.

relabel_configs allows modifivation of target and labels before scraping.

```
job_name:

scrape_interval:
scrape_timeout:

metrics_path: (default /metrics)

honor - для разруливания конфликтов статических и динамических labels.

scheme: (default http)

params:
optional HTP URL params.

dns_sd_configs: (DNS service discovery configs)

file_sd_configs:

static_configs:

sample_limit:

==============
```

### dns_sd_config

Only DNS A, AAAA, SRV, but not DNS-SD.

==========

### file_sd_config

Generic way to configure static targets.
Serves as interface to plugin in custom SD mechanisms.

Reads set of files, containing zero or more statig_configs.
Via disk watchers changes in files are detected and applied immediately.

re-reading as fallback.

each target has a meta label `__meta_filepath` during *relabeling* phase.
Value set to filepath.

```
files:
  - pattern (last path segment can have *)
refresh_inteval
```
========

### static_config

List of targets and a common label set for them.

```
targes:
 - host1
 - host2

labels:
 labelname: labelvalue
```

### relabel_config

Initially
job: job_name
`__address__`: `host:port`

After relabeling
instance: `__address__`
`__scheme__`: ...
`__metrics_path__`: ...
`__param_<name>`: first url param called `<name>`.

`__meta_*` labels may be available during relabeling.
They are set by SD mechanism.

Labels starting with `__` will be removed from label set after target
relabeling is completed.

`__tmp` prefix never uses by prometheus, so you can use it for tmp labels.

https://medium.com/quiq-blog/prometheus-relabeling-tricks-6ae62c56cbda

Use cases of relabeling:

Before storing:
* Drop metrics.
* Drop time-series (metrics with specific labels)
* Drop labels from metrics data.
* Amend label format in final metrics.

There is no easy way to tell Prometheus to not scrape some metrics.
So - relabeling.

```
- job-name: cadvisor
  metric_relabel_configs:
  - source_labels: [__name__]
    regex: '(container_tasks_state|container_memory_failures_total)'
    action: drop
```
So container_tasks_state and container_memory_failures_total
will be dropped.

`__name__` - reserved word for metric name.
?? Helps to reduce disk space ??

```
- job_name: cadvisor
  ...
  metric_relabel_configs:
  - source_labels: [id]
    regex: '/system.slice/var-lib-docker-containers.*-shm.mount'
    action: drop
  - source_labels: [container_label_JenkinsId]
    regex: '.+'
    action: drop
```

Drops time-series having a label pair like:

`id="/system.slice/var-lib-docker-containers.*-shm.mount"` or the label `container_label_JenkinsId`.



https://blog.freshtracks.io/prometheus-relabel-rules-and-the-action-parameter-39c71959354a

action parameter in relabel_config and metric_relabel_config.

`action` defaults to `replace`.

* `replace` - match `regex` against contacenated `source_labels`.
Set `target_label` to `replacement`

* `keep` - drop targets for which `regex` does not match `source_labels`.

* `drop` - drop targets for which `regex` matches `source_labels`.

* `hashmod` - set targets to `modulus` of a hash of concatenated sources.

* `labelmap` - match regex against all label names. Copy values of matching labels to label names given by replacement substituted by their value.

* `labeldrop` - match regex against all label names, remove all matched labels.

* `labelkeep` - removed non matching.







