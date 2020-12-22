---
title: Cheat Sheet
---

# Ctrl+C support

need to add -t -i to support sending ctrl+c to process within powershell

``` powershell
docker run -v '/c/_cp/Git/notebook.wiki:/wiki' -p 80:80 -t -i notebook-gollum
```

# Configuring PowerShell

Need to start the docker machine (host for containers)

``` powershell
docker-machine start default
```

configure environment so that it can connect

``` powershell
docker-machine env default --shell powershell | invoke-expression
```

should then be able to use the docker command line tool e.g. docker images

# IP of the machine

``` bash
docker-machine ip defaulta
```