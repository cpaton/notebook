---
title: Snippets
---

Check to see if there any uncommitted changes via simple exit code

``` powershell
git diff --no-ext-diff --quiet --exit-code
```

Pass configuration from local git into a docker container

``` powershell
docker container run --rm --interactive --tty ``
--mount type=bind,source=~/.ssh,target=/root/.ssh ``
--env GIT_AUTHOR_NAME='$(git config --get user.name)' ``
--env GIT_AUTHOR_EMAIL='$(git config --get user.email)' ``
--env GIT_COMMITTER_NAME='$(git config --get user.name)' ``
--env GIT_COMMITTER_EMAIL='$(git config --get user.email)' ``
alpine/git bash
```