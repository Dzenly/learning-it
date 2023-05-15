М.б. использовать tmpfs для кэша.

https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#leverage-build-cache

* Parent image.

Child image derived from the parent one with the same instruction.

**Только** ADD/COPY

Для каждого файла считается хэш.
last-modified и last-accessed времена не рассматриваются.

Если контент или метаданные файла меняются - кэш инвалидируется.

Для команд, типа RUN сравнивается только сама строка команды.

Если в цепочке команд кэш инвалидируется - все следующие команды создают новые кэши.

