---
title: SSH
---

Enable the SSH service ( Control Panel -> Terminal & SNMP )

Generate a public/private key pair using ssh-keygen

Setup the users home directory for SSH keys by logging on as root

{% highlight shell %}
cd /var/services/homes
chmod 755 User
cd User
mkdir .ssh
cat <path to public key> >> .ssh/authorized_keys
chown User .ssh
chown User .ssh/authorized_keys
chmod 700 .ssh
chmod 644 .ssh/authorized_keys
cd ..
{% endhighlight %}

Now convert the private key to a putty supported key using puttygen.

**References**

* [http://techanic.net/2014/04/12/configuring_ssh_and_scp_sftp_on_dsm_5.0_for_synology_diskstations.html](http://techanic.net/2014/04/12/configuring_ssh_and_scp_sftp_on_dsm_5.0_for_synology_diskstations.html)

You should now be able to connect using Putty to the NAS without using a password
