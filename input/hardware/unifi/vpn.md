---
title: VPN
---

### Windows 10

After configuring the VPN connection in Windows you need to make some additional changes not exposed through the main GUI.  From within network connections (ncpa.cpl) find the VPN connection and edit it.  On the security tab select Allow These Protocols and check Microsoft CHAP Version 2 (MS-CHAP v2).  Not been able to get VPN connection to work from inside the Unifi network - had to perform tests via the Mobile personal hotspot.