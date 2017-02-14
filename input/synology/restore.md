---
title: Restore Plan
---

Linux provides a kernel module called ecryptfs that provides support for an encrypted filesystem. Idea is to mount an encrypted file system container from the USB external hard disk as a shared folder on the main volume. Using the following command (which must be run as root) we are mounting a folder called Encrypted from the USB drive as EncryptedBackup on the main volume

{% highlight shell %}
mount.ecryptfs /volumeUSB1/usbshare/Encrypted /volume1/EncryptedBackup -o key=passphrase:passphrase_passwd=<passphrase>,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=n,no_sig_
cache,ecryptfs_enable_filename_crypto=n
{% endhighlight %}

Any data written to /volume1/EncryptedBackup will now be routed to the USB drive and it will be encrypted. Once this is setup you can setup a backup from within Synology to target this EncryptedBacku shared folder.

Data can then be read from another Linux machine e.g. a Raspberry Pi. It requires installing ecryptfs-utils package, creating a directory to use as the unencrypted mount point and then mounting the USB disk.

{% highlight shell %}
sudo apt-get install ecryptfs-utils
mkdir /media/pi/Unencrypted
sudo mount -t ecryptfs /media/pi/1.42.6-5022/@Backup1@ /media/pi/Unencrypted -o key=passphrase:passphrase_passwd=<passphrase>,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=n,no_sig_cache,ecryptfs_enable_filename_crypto=n
{% endhighlight %}

Note if the password/passphrase is incorrect it will still mount the disk but the contents will be meaningless.

To access the files from a windows machine you will need Samba

{% highlight shell %}
sudo apt-get install samba samba-common-bin
{% endhighlight %}

Samba configuration then needs to be updated

{% highlight shell %}
sudo nano /etc/samba/smb.conf
{% endhighlight %}

Need to setup the workgroup so that windows machines can see the share and add the share details under the share definitions section

<pre>
workgroup = WORKGROUP
wins support = yes
 
[backup]
   comment=Backup
   path=/media/pi/Unencrypted
   browseable=Yes
   writeable=Yes
   only guest=no
   create mask=0777
   directory mask=0777
   public=no
</pre>

Now add the pi user as a samba user

{% highlight shell %}
sudo smbpasswd -a pi
{% endhighlight %}

This will require a password for the pi account when attempting to connect to the share.