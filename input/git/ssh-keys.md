---
title: SSH Key Generation
---

Can do this via a one-liner in powershell e.g. to create a key called github

``` powershell
& 'C:\Program Files (x86)\Git\bin\sh.exe' --login -i -c 'ssh-keygen -t rsa -b 4096 -C ""EMAIL_ADDRESS"" -f ~/.ssh/github -N """"'
```

Alternatively from a GIT bash prompt and run the following

``` shell
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Accept the default location for the key for now. After it has complete rename the key found in %USERPROFILE%\.ssh to the name of the git host e.g. github or bitbucket. Need to do this for both the private and public key parts. Then use the instructions below to setup an ssh config file to get it to pick the correct git depending on the remote host.

Add the public key to the git host via their website or other means. Now you can test connectivity e.g.

``` shell
ssh -T -v git@bitbucket.org
```