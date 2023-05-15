https://habr.com/ru/post/467607/

* Докер добавляет свои правила файрвола,
с которыми геморно совмещать другой софт.

* По умолчанию докер бридж создается на 172.16.0.0/12

Производительность сети ниже, т.к. работает через Nat.

Воспроизводимость не такая уж и крутая, т.к.
есть нововведения, которые ломают обратную совместимость.

Образы созданные на свежем докере, могут не работать на старом.

docker hub - помойка.

Для компилируемых языков паковка в докер выглядит избыточно,
особенно для golang.

Докер перемещает хлам из точки А в точку Б.

Лучше юзать свой образ, чем публичный.

ДОкер не умеет порядок запусков.
Юзайте systemd и unit.

Вроде бы depends_on в docker-compose позволяет запустить контейнеры
последовательно.
Например, она не ждёт готовности контейнера, хотя, уже ждёт.

Правильный пакет для ubuntu - docker-ce, docker.io но не docker.

docker-compose - не ставить из репы системы или через pip.

Безопасности нет.
Особенно с bind mount.

Нельзя запускать на своей системе непроверенные контейнеры, можно повредить систему.

systemd-nspawn
kuber умеет работать с containerd


cri-o/podman/buildah


https://habr.com/ru/post/467607/#comment_20630313

https://www.reddit.com/r/docker/comments/8jk22u/docker_is_a_dangerous_gamble_which_we_will_regret/

https://news.ycombinator.com/item?id=22158176

https://lobste.rs/s/gr8rcw/docker_is_dangerous_gamble_which_we_will

https://www.youtube.com/watch?v=PivpCKEiQOQ&feature=youtu.be

