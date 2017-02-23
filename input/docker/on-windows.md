---
title: Docker On Windows
---

Docker quickstart terminal installed with Docker for windows runs

``` powershell
"C:\Program Files\Git\bin\bash.exe" --login -i "C:\Program Files\Docker Toolbox\start.sh"
```

This script creates a VirtualBox machine if one doesn't already exist and then uses ``docker-machine`` to start it and then reads configuration information from that machine using ``docker-machine env default`` to setup shell variables

To do the equivalent for PowerShell use the following

``` powershell
# Make sure docker host is running
if ( ( docker-machine status default ) -ne "Running" ) {
    docker-machine start default
    "yes" | docker-machine regenerate-certs default
}

# Get machine information and setup the environment so that we can use the docker tool
docker-machine env default --shell powershell | Invoke-Expression
Write-Host ( "Docker machine IP address is {0}" -f ( docker-machine ip default ) )
```

