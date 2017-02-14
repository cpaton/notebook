---
title: Plex
---

Download the Plex server package from [http://plex.tv](http://plex.tv) for NAS

The spk package file may not be detected by the NAS device and you might get an error

![Synology Package Not Supported]({{ site.asset_base_url }}Synology_Package_Not_Supported.png)

This is because the NAS device may be using a different architecture to that listed as supported in the package. Find the architecture for your synology device [https://github.com/SynoCommunity/spksrc/wiki/Architecture-per-Synology-model](https://github.com/SynoCommunity/spksrc/wiki/Architecture-per-Synology-model) may help

Then take the spk package file and open it within 7zip. Edit the info file and find the section arch="..." and add in the architecture for your device. See [https://forums.plex.tv/index.php/topic/39543-plex-on-synology-412-did-not-work/#entry251322](https://forums.plex.tv/index.php/topic/39543-plex-on-synology-412-did-not-work/#entry251322) for more information
