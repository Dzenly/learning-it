https://docs.docker.com/compose/production/

* Remove volume binding for app code.
* Diferent ports.
* Env vars: logs verbosity, external resources usage.
* Restart policy.
* Log aggregator.

# Deploying changes

docker-compose build web
docker-compose up --no-deps -d web

# Single server

Env vars:
* DOCKER_HOST
* DOCKER_TLS_VERIFY
* DOCKER_CERT_PATH

