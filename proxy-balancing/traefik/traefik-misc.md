https://docs.traefik.io/

Real time configuration. No restarts, no connect interruptions.

# Edge router

Intercepts and routes incoming requests.
Knows which service handles which request.

# Auto service discovery

No need in cfg file.
Traefik gets cfg from sevices itself.

Service should give info to traefik ?

middleware - can chahge request before routing.

providers - allow to discover services.

```
labels:
  - "traefik.http.routers.whoami.rule=Host(`whoami.docker.localhost`)"
```

docker-compose up -d --scale whoami=2
And get auto-balancing from traefik.

https://doc.traefik.io/traefik/getting-started/quick-start/

docker-compose умеет скейлить.
И traefik подхватывает конфиги и балансирует нагрузку.

# Configuration introduction.

## Dynamic

From providers.
HTTPS certificates belongs to dynamic configuration.

## Static

Mutually exclusive (evaluated in such order):
* Config file (traefik.toml, traefik.yml, traefik.yaml). In /etc/traefik, $XDG_CONFIG_HOME/, $HOME/.config/, CWD. Also --configFile arg.
* Command line args.
* Env vars.

Options have sub-options.

============================

Как работает реверс прокси.
Может защищать от атак, и собирать статистику,
поддерживать ssl, хотя проксируемый сервер может и не поддерживать.
Может балансировать нагрузку.
Кэшировать статику и динамику, уменьшать тем самым нагрузку на сервисы.
Сжатие трафика.













https://habr.com/ru/post/508636/

Traefik это обратный прокси.

К бд тоже можно ходить извне через traefik.

Балансирует нагрузку.

Вводить SSL.

Аутентификацию клиента и брандмауэр.

Брандмауэр - синоним файрвола.

Edge Router.
https://searchnetworking.techtarget.com/definition/edge-router

Docker, File providers.

Может проксировать HTTP/TCP/UDP.

Регулярные выражения - в фигурных скобках.
{name:reg_exp}.

letsEncrypt - бесплатные сертификаты.

Мониторинг:
```
entryPoints:
...
  metrics:
    address: ":8082"
```

 И настройка prometheus для сбора с traefik_ip:8082.



