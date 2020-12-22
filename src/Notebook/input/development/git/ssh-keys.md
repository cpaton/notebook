---
title: SSH Key Generation
---

Can do this via a one-liner in powershell e.g. to create a key called github

``` powershell
& 'C:\Program Files (x86)\Git\bin\sh.exe' --login -i -c 'ssh-keygen -t rsa -b 4096 -C ""EMAIL_ADDRESS"" -f ~/.ssh/github -N """"'
```

Alternatively from a GIT bash prompt run the following

``` shell
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Accept the default location for the key for now. After the key is generated rename the key found in %USERPROFILE%\.ssh to the name of the git host e.g. github or bitbucket for both the private and public key parts. Use these [instructions](ssh-key-per-host.html) to setup an ssh config file to get it to pick the correct key depending on the remote host.

Add the public key to the git host via their website or other means. Test connectivity by

``` shell
ssh -T -v git@bitbucket.org
```