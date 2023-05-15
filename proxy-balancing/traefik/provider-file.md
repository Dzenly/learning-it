https://doc.traefik.io/traefik/providers/file/

traefik uses fsnotify.

Use directory with pointing to parent directory.

```yaml
providers:
  file:
    filename: /path/to/config/dynamic_conf.yml
```

```yaml
providers:
  file:
    directory: /path/to/config
```

watch works for both cases.

Go templating works only for dynamic files, and does not work for static
ones.



