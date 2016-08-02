---
title: GMail Backup (GMVault)
---

Install Python 2.7 package from the package centre

Setup the directory structure to run GMVault from

Create an isolated Python virtual environment to run GMVault from. Blogs recommended using a specific version of python virtual environment as the lastest version on GitHub apparently had issues as of Jan 2015

{% highlight shell %}
cd GMVault
wget https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.10.1.tar.gz
tar xzf virtualenv-1.10.1.tar.gz
python ./virtualenv-1.10.1/virtualenv.py gmvault_env
{% endhighlight %}

Install GMVault using the python package manager - requesting pre-requsites from within the new virutal environment

{% highlight shell %}
cd gmvault_env/bin
./activate
./pip install --pre gmvault
{% endhighlight %}

Test out the GMVault installation, note as Synology doesn't have a bash shell you need to run it explicitly using sh - you should get some output complaining about missing arguments

{% highlight shell %}
sh ./gmvault
{% endhighlight %}

Being logged in as the user you will run the backup regularly as do a test backup - this will setup the authentication with GMail using OAuth. This same trick can also be used if the authentication starts failing for some reason e.g. when google moved to only support OAuth v2. First you will need to remove any cached auth tokens from $HOME/.gmvault and then run the command

{% highlight shell %}
sh ./gmvault sync <email address>
{% endhighlight %}

Hit enter when it says it will open a browser, this will fail but a link will be displayed that you can use to setup the OAuth autorisation.

After that you should be good to go ahead with the backups

### Sample script

{% highlight shell %}
#!/bin/sh
 
NOW=$(date +"%Y%m%d%H%M")
LOGFILE="/volume1/Data/Backup/Log/email@domain-$NOW.log"
CURTIME=$(date +"%r")
 
echo "------------------------------------" >> $LOGFILE
echo "$CURTIME: Starting email sync..." >> $LOGFILE
echo "------------------------------------" >> $LOGFILE
printf "\n" >> $LOGFILE
 
whoami >> $LOGFILE
set >> $LOGFILE
 
cd /var/services/homes/admin
/volume1/Data/Backup/GMail/GMVault/gmvault_env/bin/activate
sh /volume1/Data/Backup/GMail/GMVault/gmvault_env/bin/gmvault sync -t full -d /volume1/Data/Backup/GMail/ emailaddress >> $LOGFILE 2>&1
 
CURTIME=$(date +"%r")
 
printf "\n" >> $LOGFILE
echo "------------------------------------" >> $LOGFILE
echo "$CURTIME: email sync finished." >> $LOGFILE
echo "------------------------------------" >> $LOGFILE
{% endhighlight %}

To update gmvault to the latest version use pip

{% highlight shell %}
cd /volume1/Data/Backup/GMail/GMVault/gmvault_env/bin
./pip install -U gmvault
{% endhighlight %}

**References**

* [http://workingconcept.com/blog/synology-gmail-backup](http://workingconcept.com/blog/synology-gmail-backup)
* [http://jimmybonney.com/articles/install_gmvault_on_a_synology_nas_follow_up/](http://jimmybonney.com/articles/install_gmvault_on_a_synology_nas_follow_up/)
