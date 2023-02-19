


# План:

Завести репу с дефолтными настройками renovate.
И можно эти дефолты экстендить.



batched update - опционально.
Dependency Dashboard

packageRule.

Автоматически или вручную.

Прогнать автотесты для МР.

Disable major updates ?

==================

https://github.com/renovatebot/renovate

Package files are discovered automatically.
Lerna and yarn workspaces.

Lock files are also updated automatically in the same commit.

Customizable by config files

Github, Gitlab, Gitea.

https://docs.renovatebot.com/modules/platform/gitlab/

Personal Access Token to config.js file.

RENOVATE_HOST_RULES

RENOVATE_HOST_RULES CI variable to [{"matchHost": "${CI_REGISTRY}","username": "${GITLAB_USER_NAME}","password": "${RENOVATE_TOKEN}"}].


no automergeStrategy for gitlab yet.
Merge strategy .
Only one MR assigne for free gitlab.

============

package.json
Gemfile
go.mod

============

`npm, Yarn, Bundler, Composer, Poetry, Pipenv, and Cargo all support or use lock files.`

npm i for package-lock.json generation.

New tags for Dockerfiles.
And seems like digests too.

============

By default each dependency in itw own MR.
But you can use batch updates.

packageRules groupName

time ranges
`schedule` field.

============

Dependency Dashboard issue.
Lists updates which are pending, in progress,

============

configuration presets
To DRY

There are over 100 built-in presets

============

https://docs.renovatebot.com/getting-started/running/




============


============




