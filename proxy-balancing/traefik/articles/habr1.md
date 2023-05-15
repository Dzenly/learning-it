https://habr.com/ru/post/508636/

Edge router, то есть точка, которая одним концом смотрит во внутреннюю сеть, а другим - во внешнюю.

Есть провайдеры, типа docker, kuber, consul, rancher, file.

File - конфиг, где описана конфигурация, какого-то сервиса,
который должен быть скрыт за реверс-прокси.

TOML, YAML,

```
volumes:
  - /etc/localtime:/etc/localtime:ro
  - /var/run/docker.sock:/var/run/docker.sock:ro
```
Проброс докера - для автоматической конфигурации.

Traefik должен иметь доступ к докерным сетям, с которыми работает.

traefik.yml
```yml
entryPoints:
  http:
    address: ":80"
  https:
    address: ":443"

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false

http:
  routers:
    http-catchall: # Имя роутера, любое, но уникальное в рамках блока http.
      rule: HostRegexp(`{host:.+}`) # Фильтр трафика для роутера.
      # Регулярное выражение в фигурных скобках и имеет наименование (тут host)
      entrypoints: # Используемые точки входа, из описанных ранее.
      - http
      middlewares: # Промежуточные обработчики перед передачей сервису.
      - redirect-to-https
  middlewares:
    redirect-to-https:
    redirectScheme:
    scheme: https # вынуждаем использовать https.
    permanent: false

```

Traefik может проксировать не только HTTP трафик, но и просто TCP и UDP.

# Роутеры




=========

htpasswd -nb admin password
admin:$apr1$vDSqkf.v$GTJOtsd9CBiAFFnHTI2Ds1






