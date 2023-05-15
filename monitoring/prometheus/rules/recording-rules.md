https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/

Rule file reloaded at runtime by sending SIGHUP.

go get github.com/prometheus/prometheus/cmd/promtool
promtool check rules /path/to/example.rules.yml

precompute some expressions.

```
groups:
  - <rule_group>
```

record: - the name of time series to output to.

expr: - PromQL expression to evaluate.

labels: - to add or overwrite before storing result.

==========




