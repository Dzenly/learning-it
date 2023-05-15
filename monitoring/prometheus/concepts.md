https://prometheus.io/docs/concepts/data_model/

Time series streams.

labeled dimensions ??

Derived temporary series.

======

Metric *name*.
General feature of a system (e.g. http_request_total).


*Labels* - optional key-value pairs.
Enable prom dimensional data model.
Combo of labels for the same metrics *name*
E.g. HTTP requests, that use POST to the /api/xxx path.
Query language allows filtering and aggregation based on labels.

Notation

`api_http_requests_total{method="POST", handler="/messages"}`
method=... and handler=... are labels.

https://prometheus.io/docs/concepts/metric_types/

counter  - single, monotonically increasing counter.
gauge - up/down (mem usage, temperature)
histogram - configurable buckets.
summary - histogram + sliding window of quantiles.


https://prometheus.io/docs/practices/histograms/
Average req duration during last 5 minutes:
```
rate(http_request_duration_seconds_sum[5m])
/
rate(http_request_duration_seconds_count[5m])
```

```
sum(rate(http_request_duration_seconds_bucket{le="0.3"}[5m])) by (job)
/
sum(rate(http_request_duration_seconds_count[5m])) by (job)
```

You can use brackets:
e.g. for Apdex:
```
(
  sum(rate(http_request_duration_seconds_bucket{le="0.3"}[5m])) by (job)
+
  sum(rate(http_request_duration_seconds_bucket{le="1.2"}[5m])) by (job)
) / 2 / sum(rate(http_request_duration_seconds_count[5m])) by (job)
```

le=1.2 bucket contains le=0.3 bucket.

фи - квантиль, например 0.95 - это 95й персентиль.

=======

Summaries - streaming фи квантили from client side.
А histogramms bucketed observation counts on back end using histogram_quantile func.

https://prometheus.io/docs/concepts/jobs_instances/

*Instance* - endpoing you scrapped.
*Job* - collection of instances with the same purpose.













