---
title: Notifications
---

/usr/syno/bin/synodsmnotify can be used to send notifications to the DSM interface. To send to a user you need to be able to write to that users notification file - this requires permissions to be setup - as by default only root can write to it

{% highlight shell %}
chmod 666 /usr/syno/etc/preference/admin/dsmnotify
{% endhighlight %}

Notifications can then be sent by

{% highlight shell %}
/usr/syno/bin/synodsmnotify "admin" "Title" "Message"
{% endhighlight %}

Add admin user so it can send emails - as root

{% highlight shell %}
synogroup --member maildrop admin
{% endhighlight %}

Then as the admin user you should be able to send mail using

{% highlight shell %}
/usr/bin/php -r "mail('<to address>', 'Subject', 'Body', 'From: <address>');"
{% endhighlight %}

**References**

* [http://forum.synology.com/enu/viewtopic.php?f=32&t=79334](http://forum.synology.com/enu/viewtopic.php?f=32&t=79334)
* [http://forum.synology.com/enu/viewtopic.php?f=27&t=55627](http://forum.synology.com/enu/viewtopic.php?f=27&t=55627)