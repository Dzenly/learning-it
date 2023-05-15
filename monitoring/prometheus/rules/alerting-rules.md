https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/

## Alerting rules

alert: <string> - name of the alert. (valid lable value??)

expr: PromQL expression to evaluate. Every evaluation cycle this expression
is evaluated at the current time, and all resultant time series become
pending/firing alerts.

for: <duration> (default 0s)

# labels to add or overwrite for each alert.
labels:
labelname: <tmpl_string>

annotations:
  <labelname>: <tmpl_string>


https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/

Когда alert expression results in vector elements at a give point of time,
Alert considered as active for these elements *label sets*.

```
groups:
- name: example
  rules:
  - alert: HighRequestLatency
    expr: job:request_latency_seconds:mean5m{job="myjob"} > 0.5
    for: 10m
    labels:
      severity: page
    annotations:
      summary: High request latency
```

`for` - Как я понял - в течение этого времени expr должно всегда выдавать
вектор (т.е. быть true). И это true называется что алерт активный.

?? Как часто идут пересчеты ?

*pending* - активный, но пока не отосланный.

`labels` - additional labels to attach to alert.
can be templated.

`annotations` - set of informational labels (?? what difference from labels ??)
can be templated.






