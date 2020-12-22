---
title: SSH Key Per Host
---

By default ssh keys are looked in a .ssh subdirectory of the users home directory. When connecting via git it will look for a id_rsa key by default. To use a different key for a specific host place a config file in that directory and add something along the lines of the following (make sure you use Linux line endings)

<pre>
Host               storage
    Hostname       storage
    IdentityFile   ~/.ssh/synology_craig
    IdentitiesOnly yes
 
Host               bitbucket.org
    Hostname       bitbucket.org
    IdentityFile   ~/.ssh/id_rsa_bitbucket_user
    IdentitiesOnly yes
</pre>

Careful with the host name as what you use when connecting to remote git repository is how it is looked up. For example when connecting to bitbucket you will get a ssh spec like

``` bash
git clone git@bitbucket.org:user/repo.git
```

In this case it will look for a line in the config file with the Host of bitbucket.org - if you have used just bitbucket for the host it will not be found and the identity file you specified will not be used.

To diagnose issues open a git-bash prompt and use

``` bash
ssh -T -v git@bitbucket.org
```

This will provide detailed logging of the attempted connection and show you which identity files it attempted to use.

**References**

* [http://stackoverflow.com/questions/4565700/specify-private-ssh-key-to-use-when-executing-shell-command-with-or-without-ruby](http://stackoverflow.com/questions/4565700/specify-private-ssh-key-to-use-when-executing-shell-command-with-or-without-ruby)