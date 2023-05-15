https://docs.docker.com/compose/environment-variables/

# In compose file

```yml
web:
  image: "webapp:${TAG}"
```

# Set in containers

```yml
web:
  environment:
  - DEBUG=1
```

docker run -e VARIABLE=VALUE

# Pass to containers

```yml
web:
  environment:
  - DEBUG
```

docker run -e VARIABLE

# env_file

docker run --env-file=FILE

```yml
web:
  env_file:
    - web-variables.env
```

# Set/pass by docker-compose run -e

docker-compose run -e DEBUG=1 web python console.py
docker-compose run -e DEBUG web python console.py

# .env file

default values for variables referenced in compose file.

.env
TAG=v1.5

docker-compose.yml
```yml
version: '3'
services:
  web:
    image: "webapp:${TAG}"
```

`docker-compose config` - **shows yaml after substitution**.

*Values in the shell take precedence over specified in .env.*

Precedence order:

* Compose file
* Shell environment variables
* Environment file
* Dockerfile
* Variable is not defined

# Specific for Node.js containers:

*Vars from package.json->scrips overrules variables in docker-compose.yml.*

# Configure Compose using env vars:

COMPOSE_* and DOCKER* vars.
https://docs.docker.com/compose/reference/envvars/

# Vars created by links

deprecated.

https://docs.docker.com/compose/env-file/

.env
Default env vars.

You can set predifined vars also.













