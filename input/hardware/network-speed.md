---
title: Network Speed
---

[iPerf](https://iperf.fr/) used to test the network speed.  It needs two computers one to act as the server and the other as a client.  Its very simple to get some results.  On the server run

``` powershell
.\iperf3.exe --server --verbose --version4 --format M
```

On the client run

``` powershell
.\iperf3.exe --client SERVER_MACHINE_IP --verbose --version4 --format M --port 5201
```
# Hardware

Netgear N600 DGND3700 router that has a gigabit switch and supports 2.4 and 5GHz Wifi networks.

Lenovo W520 used as the server connected directly to Netgear N600 router via a wired connection speed reported as 1Gb

# Results

## Wired

Lenonvo Carbon X1 with a gigabit ethernet

| Scenario | Avg Speed (MByte/sec) | Comments / Observations |
|---|:-:|---|
| Wired connection (1Gb) | 100 | |
| Wired connection (100Mb) | 11.3 | Netgear switch restricts connection even though it supports gigabit |

## Wifi

Lenonvo Carbon X1 with an Intel Dual Band Wireless-N 7260 which supports both 2.4 and 5Ghz bands and 802.11a/b/g/n protocols.

| Scenario | Avg Speed (MByte/sec) | Comments / Observations |
|---|:-:|---|
| Wifi 5GHz Same Room | 1.8 | This is supiciously slow, connection made uses the a protocol, should be using n |
| Wifi 2.4GHz Same Room | 7.7 | |
| Wifi 2.4GHz Same Room (5Ghz off) | 8.8 | Not sure why 5Ghz on would cause a difference |
| Wifi 2.4GHz Floor above | 6.5 | |
| Wifi 2.4GHz Floor below | 4.0 | |

## Powerline

TP-LINK 500 Mbps used as the Powerline adapters (TL-PA511KIT)

| Scenario | Avg Speed (MByte/sec) | Comments / Observations |
|---|:-:|---|
| PowerLine Same Floor | 14.2 | |
| PowerLine Floor Above | 8.9 | |
| PowerLine Floor Below | 8.5 | |
| PowerLine Floor Below (Switch) | 8.4 | Additional switch between client and powerline, makes no difference as expected |

## iPhone

iPhone test done using [Wifi Sweetspots](https://itunes.apple.com/us/app/cloudcheck/id722428563?mt=8) for an average speed over at least one minute with an iPhone 7 supporting 802.11a/b/g/n/ac

| Scenario | Avg Speed (MByte/sec) | Comments / Observations |
|---|:-:|---|
| 5GHz Same Room | 3 | |
| 2.4GHz Same Room | 12.8 | |
| 5GHz Floor Below | 2.3 |
| 2.4GHz Floor Below | 2.7 |

