---
title: CrashPlan
---

CrashPlan consists of two parts, a server and a client that connects to the server for configuration and monitoring. On a NAS device you install just the server in what is called headless mode. Follow the instructions from

* [http://www.hanselman.com/blog/UPDATED2014HowToSetupCrashPlanCloudBackupOnASynologyNASRunningDSM50.aspx](http://www.hanselman.com/blog/UPDATED2014HowToSetupCrashPlanCloudBackupOnASynologyNASRunningDSM50.aspx)
* [http://pcloadletter.co.uk/2012/01/30/crashplan-syno-package/](http://pcloadletter.co.uk/2012/01/30/crashplan-syno-package/)
* [https://miketabor.com/install-crashplan-synology/](https://miketabor.com/install-crashplan-synology/) - slighty more up to date than PC load letter

Essentially

* Install Java
* Enable home service on the NAS
* Install the CrashPlan package from PCLoadLetter
* Setup client on a PC to connect to the server running on the NAS and configure it

Crashplan via docker

* [https://miketabor.com/run-crashplan-docker-synology-nas/](https://miketabor.com/run-crashplan-docker-synology-nas/)
* [https://github.com/JrCs/docker-crashplan](https://github.com/JrCs/docker-crashplan)

Not been able to get it working yet.  Container starts and able to connect from windows client but not able to successfully enter the credentials.  Client is reporting the error CPC_UNAVILABLE

# Windows Client

Two items need to be configured to use the windows client to connect to the Synology daemon

* **C:\Program Files\CrashPlan\conf\ui.properties** need to update serviceHost to the IP address of the Synology
* Copy the file **/var/lib/crashplan/.ui_info** from the Synology to **C:\ProgramData\CrashPlan\\.ui_info** (this file includes a port number and a GUID). The last part is the IP address of the Synology device this should be updated

# Fails to start

## Installing upgrade then stops >= 4.7.0

<pre>
I 10/01/16 11:05AM CrashPlan started, version 4.7.0, GUID 674279968953860117
I 10/01/16 11:05AM Downloading a new version of CrashPlan.
I 10/01/16 11:05AM Download of upgrade complete - version 1435813200480.
I 10/01/16 11:05AM Installing upgrade - version 1435813200480
I 10/01/16 11:05AM Upgrade installed - version 1435813200480
I 10/01/16 11:06AM CrashPlan stopped, version 4.7.0, GUID 674279968953860117
</pre>

Since around v4.7.0 CrashPlan switch to delivering the upgrades archive packages that can be extracted via the cpio utility.  The upgrade comes as an upgrade.cpi file.  First this needs to be unzipped, then the cpio utility can extract the contents.  Once compete the upgrade file should be removed so that it doesn't attempt to apply the upgrade when the service next starts

``` bash
cd /var/packages/CrashPlan/target
mv ./upgrade.cpi upgrade.cpi.gz
gunzip upgrade.cpi.gz
bin/cpio -i < upgrade.cpi
rm upgrade.cpi
```

Should be able to start the service now

The comments of this (blog post)[https://pcloadletter.co.uk/2012/01/30/crashplan-syno-package/comment-page-42/#comments] seem to get updated as new problems are hit with versions

This (post)[https://crashplan.setepontos.com/crashplan-4-7-0-installation/] specifically talks about v4.7.0

## Repairing upgrade <4.7.0

CrashPlan package fails to start on the synology. Viewing the log file from within the package manager shows something like

<pre>
I 05/14/15 08:19PM Upgrades available at central.crashplan.com:443
I 05/14/15 08:19PM Downloading a new version of CrashPlan.
I 05/14/15 08:19PM Download of upgrade complete - version 1425276000420.
I 05/14/15 08:19PM Installing upgrade - version 1425276000420
I 05/14/15 08:20PM Upgrade installed - version 1425276000420
I 05/14/15 08:20PM CrashPlan stopped, version 3.7.0, GUID 674279968953860117
I 05/14/15 10:46PM Synology repairing upgrade in /var/packages/CrashPlan/target/upgrade/1425276000420.1431634799825
I 05/14/15 10:54PM Synology repairing upgrade in /var/packages/CrashPlan/target/upgrade/1425276000420.1431634799825
I 05/16/15 11:32AM Synology repairing upgrade in /var/packages/CrashPlan/target/upgrade/1425276000420.1431634799825
</pre>

This seemed to happen after the upgrade to DSM 5.2.

Instructions to fix are [here](http://chrisnelson.ca/2015/01/10/fixing-crashplan-on-synology-after-the-3-7-0-update-synology-repairing-upgrade-in-varpackagescrashplantargetupgrade1388728800370/)

These instructions were for a different update version than above but the same principles apply

CrashPlan update appears to be a jar file that will be stored in /var/packages/CrashPlan/target/upgrade. Opening that in 7zip shows the files that make up the upgrade - this will likely be some jar files other directories e.g. localisation files, ui theme upgrades etc and an upgrade.sh script. The upgrade.sh script appears to be shared across releases and looks to see if the upgrade contains folders/files and moves them if they exist into the installed locaiton. As a result it refrences some paths that don't exist. One of the main problems it has on synology is that the normal daemon processes don't exist so it can't find/start them.

Essence of the upgrade is to copy jar files into ../../lib, if the upgrade script has run multiple times it will have moved jar files from the upgrade directory and they may have been deleted in subsequent runs (e.g. com*42*.jar files in the script looked at). View the upgrade.sh file to see all the steps carried out

Had issues using the unzip command to extract and copy the files directly to the install location, so choose to unzip into a temporary directory and manually copy the files. General gist of the commands are

``` bash
unzip -o /var/packages/CrashPlan/target/upgrade/1388728800370.jar *.jar -d /var/packages/CrashPlan/target/lib/
unzip -o /var/packages/CrashPlan/target/upgrade/1388728800370.jar run.conf -d /var/packages/CrashPlan/target/bin/
unzip -o /var/packages/CrashPlan/target/upgrade/1388728800370.jar lang/* -d /var/packages/CrashPlan/target/
ls -l /var/packages/CrashPlan/target/upgrade/1388728800370.*
mv /var/packages/CrashPlan/target/upgrade/1388728800370.whatevervalue/upgrade.sh /var/packages/CrashPlan/target/upgrade/1388728800370.whatevervalue/upgrade.sh.old
```

or my version

``` bash
cd /var/packages/CrashPlan/target/upgrade/
mkdir tmp
cp 1425276000420.jar tmp
cd tmp
unzip 1425276000420.jar
cp *.jar ../../lib
rm ../../lib/1425276000420.jar
cd ..
rm -r tmp/
1425276000420.1431634799825/
mv upgrade.sh upgrade.sh.old
```

Should now be able to start the package again from the package manager

``` bash
tail -f /var/packages/CrashPlan/target/log/history.log.0
```

## Starts then stops immediately

Viewing the log from the package manager shows that the service starts and then stops immediately not reporting any more information

<pre>
I 01/04/16 08:17PM CrashPlan started, version 4.5.0, GUID 674279968953860117
I 01/04/16 08:17PM CrashPlan stopped, version 4.5.0, GUID 674279968953860117
</pre>

Note this log file can be found at /var/packages/CrashPlan/target/log/history.log.0

To find more detailed information you need to check the other logs also found at /var/packages/CrashPlan/target/log. In this scenario the log that had the most useful information was service.log.0

<pre>
[01.04.16 20:17:16.731 ERROR main         ackup42.service.ui.UIInfoUtility] Missing an expected field in the .ui_info file; continuing, it will be recreated.
[01.04.16 20:17:16.734 ERROR main           com.backup42.service.CPService] Error starting up, java.lang.NumberFormatException: For input string: ""
STACKTRACE:: java.lang.NumberFormatException: For input string: ""
	at java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)
	at java.lang.Integer.parseInt(Integer.java:504)
	at java.lang.Integer.parseInt(Integer.java:527)
	at com.backup42.service.ui.UIInfoUtility$UIConnectionDetailsResult.getPort(UIInfoUtility.java:179)
	at com.backup42.service.ui.UIInfoUtility.hasUIConnectionDetails(UIInfoUtility.java:139)
	at com.backup42.service.CPService.writeUIInfoFile(CPService.java:1327)
	at com.backup42.service.CPService.start(CPService.java:612)
	at com.backup42.service.CPService.main(CPService.java:2239)
...
</pre>

Suggested an issue in the ui_info configration file. This is stored at /var/lib/crashplan/.ui_info. Looking at the file it was empty. The log suggests that it would be recreated but that wasn't happening. Delete the empty file and try starting the service again. This should generate a new file from scratch and allow the service to start running again. Note you will need to update the ui_info configuration file on your windows boxes to use this new GUID to connect to the headless service.