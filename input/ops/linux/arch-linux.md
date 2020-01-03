---
title: Arch Linux Install
---

Instructions taken from [https://wiki.archlinux.org/index.php/Installation_guide](https://wiki.archlinux.org/index.php/Installation_guide)

# Hyper-V Setup

Disable secure boot for UEFI

# Boot

Switch to use the UK keyboard and time sync

```
loadkeys uk
timedatectl set-ntp true
```

# Paritions

As Hyper-V will be using UEFI boot, GPT type of partition table will be used as opposed to MBR ([details](https://wiki.archlinux.org/index.php/Partitioning#Choosing_between_GPT_and_MBR)).  Use the [GTP fdisk utility (aka gdisk)](https://wiki.archlinux.org/index.php/GPT_fdisk) to setup two paritions

| Partition | Linux Mount Point | Type Code | Type | Size | Comment |
| /dev/sda1 | /boot | ef00 | EFI System | 512M | UEFI boot disk |
| /dev/sda2 | | 8200 | Linux Swap | 1G | Swap disk automounted by systemd |
| /dev/sda3 | / | 8300 | Linux FileSystem | * | Root file system |

| Partition | Linux Mount Point | Type Code | Type | Size | Comment |
| /dev/sda1 | /boot | ef00 | EFI System | 512M | UEFI boot disk |
| /dev/sda2 | / | 8300 | Linux FileSystem | * | Root file system |

```
gdisk /dev/sda # use lsblk to find the name of the disk
o # this creates a new empty GPT

# EFI system partition
n # create a new partition
# Accept default parition number
+1M # start sector leaving room for an MBR later
+512M # parition size
ef00 # EFI system partition

# Root filesystem
n
# accept default partition number, start (one sector after previous) and end sectors (end of disk)
8304 # as partition type - Linux root file system

p # print the partition table
```

Once created format the partitions 

```
> mkfs.fat -F32 /dev/sda1 # EFI partition must be a FAT variant
> mkfs.ext4 /dev/sda2
``` 

Mount the root and boot filesystem

```
mnt /dev/sda2 /mnt 
mkdir /mnt/boot
mnt /dev/sda1 /mnt/boot 
```

# Base Installation

Install the core linux packages using the Arch bootstrapper

```
pacstrap /mnt base linux linux-firmware
```

# Configuration

Make sure the filesystem is automounted on boot and change to use the new filesystem as root

```
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

Timezone

```
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
```

# Boot

Use systemd-boot boot loader that is built into Arch

/boot/loader/loader.conf controls the boot order and options
/boot/loader/entries/*.conf are the boot entries

Add entry for Arch

```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=XXX rw
```

vmlinuz-linux is a gzip compressed linux kernel which is used to load the real kernel. To load the kernel it needs some tools and a workspace which is done in the initial RAM disk (initrd).  The intel-ucode image is used to auto-load intel microcode updates, and initramfs-linux.img contains the basic tools to initialise a linux kernel and load the modules

Options specify the location of the partition which contains the root file system.  This is /dev/sda2 from the partitions setup above.  You can find the UUID via

```
blkid -s PARTUUID -o value /dev/sda2
```

At this point copy-paste doesn't work so to avoid having to type in the GUID correctly would suggest appending it to the arch.conf file and editing later in nano

```
blkid -s PARTUUID -o value /dev/sda2 >> /boot/loader/entries/arch.conf
```

The loader.conf file can then be setup

```
timeout 5
default arch
editor  0
```

editor option prevents users from specifying kernel parameters on startup - something that if enabled would allow a user to bypass the root login

# Customisation of install

Setup DHCP to run on startup using systemd systemctl command to enable the dhcpcd (DHCP client daemon) service/unit.  Specify the interface name after the @ as the instance name.  To find the name of the interface run ip link

```
systemctl enable dhcpcd@eth0.service
reboot
```