---
title: Git Backup
---

Central repository needs to be bare to support easy pushing

``` bash
git init --bare <Repo Name>
```

Setup a copy of the Git Repo, setting the core.filemode configuration option to false. This stops git thinking there are differences on Linux based purely on permisson differences

``` bash
git clone -c core.filemode=false <Path to Repo> <Repo Name>
```

Within CrashPlan make sure that the .git directory has been setup to be excluded. Settings -> Backup -> Filename Exclusions.

``` bash
.*/\.git.*
```