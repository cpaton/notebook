---
title: Notifications
---

/usr/syno/bin/synodsmnotify can be used to send notifications to the DSM interface. To send to a user you need to be able to write to that users notification file - this requires permissions to be setup - as by default only root can write to it

``` bash
chmod 666 /usr/syno/etc/preference/admin/dsmnotify
```

Notifications can then be sent by

``` bash
/usr/syno/bin/synodsmnotify "admin" "Title" "Message"
```

Add admin user so it can send emails - as root

``` bash
synogroup --member maildrop admin
```

Then as the admin user you should be able to send mail using

``` bash
/usr/bin/php -r "mail('<to address>', 'Subject', 'Body', 'From: <address>');"
```

**References**

* [http://forum.synology.com/enu/viewtopic.php?f=32&t=79334](http://forum.synology.com/enu/viewtopic.php?f=32&t=79334)
* [http://forum.synology.com/enu/viewtopic.php?f=27&t=55627](http://forum.synology.com/enu/viewtopic.php?f=27&t=55627)