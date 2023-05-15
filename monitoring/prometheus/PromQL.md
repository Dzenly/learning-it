https://prometheus.io/docs/prometheus/latest/querying/basics/

Select and aggregate ts data in real time.

Data types:

Instant тут означает мгновенный.

* Instant vector - set ts with single sample all sharing the same timestamp.
* Range vector - vector for time range
* Scalar - numeric floaing point value
* String - String value (currently unused ??)

Instant vectors can be graphed.

======
filter =
metric name
http_requests_total
+ labels in {}.

job - it is label.

* `=` - exactly equal
* `!=` - not equal
* `=~` - regex
* `!~` - not regex

Comma works as END.

Empty label value is equal to absense of label.

`{job=~".*"} # Bad!` - matches empty string so illegal.

`__name__` - internal label for metric name.

 expression `http_requests_total` is equivalent to `{__name__="http_requests_total"}.`

 https://github.com/google/re2/wiki/Syntax


## Range Vector selectors

Square brackets.

* s - seconds
* m
* h
* d
* w
* y

==

offset

==============

## Operators
https://prometheus.io/docs/prometheus/latest/querying/operators/


sum without (instance) (http_requests_total)

## Functions
https://prometheus.io/docs/prometheus/latest/querying/functions/




