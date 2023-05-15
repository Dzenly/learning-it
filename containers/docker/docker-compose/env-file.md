https://docs.docker.com/compose/compose-file/compose-file-v3/#env_file

environment sesction overrides env_file.

```
env_file:
  - ./common.env
  - ./apps/web.env
  - /opt/runtime_opts.env
```

Next file in the list - overrides the same vars from prev file.

These vars are not visible in build stage (in Dockerfiles).






