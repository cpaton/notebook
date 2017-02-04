---
title: VPN
---

### Windows 10

The VPN client built into Windows 10 doesn't work with L2TP/IPSEC VPN servers behind NAT.  Need to change a registry key to get this work.  

On Windows 10 there seems to be a 2 phase process to get this work.  First set the value to 1 reboot and then update to 2.

* [Knowlege base article](https://support.microsoft.com/en-us/help/926179/how-to-configure-an-l2tp-ipsec-server-behind-a-nat-t-device-in-windows-vista-and-in-windows-server-2008)
* [Forum for Windows 10](https://answers.microsoft.com/en-us/windows/forum/windows_10-networking/l2tp-registry-change-to-work-with-nat-t-not/f864ba86-a01b-42b5-93cd-e70c5fdf4fb3)