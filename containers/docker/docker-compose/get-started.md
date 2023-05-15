https://docs.docker.com/compose/gettingstarted/

If there is dependency, app should handle case
when container started but not fully initialized yet.

Also and multi container environments dependent services should correctly
handle temporarely dependency down (say for restart).

`docker-compose up` - build/rebuild.

`docker-compose ps`

`docker-compose run app-name env`

`docker-compose down --volumes`

