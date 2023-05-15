https://git-scm.com/docs/git-pull

`git pull [opts] [repo [refspec]]`

refspec - usually - name of branch in remote repo.

`git fetch` + `git merge FETCH_HEAD` (or `git rebase`)

```
     A---B---C master on origin
    /
D---E---F---G master
    ^
origin/master in your repository
```

git pull will fetch and replay the changes from the remote `master`.

https://stackoverflow.com/questions/45137769/git-what-does-exactly-git-pull-do/45138435

four types objects:

* commits
* (annotated) tags
* trees
* blob

git cat-file - вытащить git object.

FETCH_HEAD file - contains hash ids.






