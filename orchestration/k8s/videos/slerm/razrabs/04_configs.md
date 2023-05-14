https://www.youtube.com/watch?v=-xZ02dEF6kU&list=PL8D2P0ruohOBSA_CDqJLflJ8FLJNe26K-&index=4&ab_channel=%D0%A1%D0%BB%D1%91%D1%80%D0%BC

ConfigMap
Переменные окружения.

Один для несколько деплойментов.

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap-env
data:
  dbhost: postgresql
  DEBUG: "false"
```

`k get cm`

```deployment.yml
envFrom
  configMapRef
```

# Secrets

* generic
* docker-registry
* tls

`k create secret type name`

Хранят base64 конфиги.

RBAC - интегрирован с секретами.
Допустим, секреты могут редактировать только Админы.

Можно частично
```yml
env:
  - name: TEST
    valueFrom:
      secretKeyRef:
        name: asdf
        key: asdf
```

k describe -  можно глянуть переменные окружения.
exec права внутрь пода обычно у разработчиков забирают.

stringData - можно plainText.

Токены из кубера могут использоваться в vault.

```yml
data:
  default.conf: |
  server {
    listen: 80 default_server;
    server_name _;
    default_type text/plain;
    ...
  }
```

volumeMounts - на уровне контейнера.
volumes - в отдельной секции.

Примерно так же, как в docker-compose.

`k port-forward my-deployment-xxxxxxxx-yyyy 8080:80`
curl localhost:8080

*Если монтируем как файлы - можем ожидать, что в контейнерах перемонтируются и перечитаются конфиги, если само приложение умеет следить за своими конфигами*

# Downward API

Позволяет передать приложению некоторые параметры манифестов
как переменные окружения или файлы.

```yml

volumes:
  - name: podinfo
  downwardAPI:
    itema:
      - path: "labels"
      fieldREf:
        fieldPath: metadata.labels
```
















