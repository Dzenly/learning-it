# Start a new feature
git checkout -b new-feature master

# Edit some files
git add <file>
git commit -m "Start a feature"

# Edit some files
git add <file>
git commit -m "Finish a feature"

# git push - ругнется и попросит ввести команду, видимо для добавления удаленного бранча.

# Merge in the new-feature branch
git checkout master
git merge new-feature 

# Если будет косяк при merge - можно попробовать вот так:
git merge new-feature --strategy recursive -X renormalize

# Удаление локального бранча

git branch -d new-feature

# Удаление удаленного бранча

git push origin :new-feature