# 0. Pre Installation

### 0.1 Aquire an arch linux iso

Download the latest iso from [archlinux.com](https://archlinux.org/download/).

### 0.2 Flash a usb drive for installation

Plugin a USB Stick with around 16GB and format it as writtenin the [USB flash installation medium](https://wiki.archlinux.org/title/USB_flash_installation_medium) guide.
I prefer **Using the ISO as is (BIOS and UEFI)** variant using [dd](https://wiki.archlinux.org/title/Dd).

# 1. Boot the live environment

### 1.1 Set the console keyboard layout

`$ loadkeys de-latin1`  
this loads the german qwertz keyboard layout.

### 1.2 Verify the boot mode

`$ cat /sys/firmware/efi/fw_platform_size`
this ensures that u booted in to UEFI mode.
I had to change my boot settings from UEFI+LEGACY_BOOT to only UEFI in my BIOS Menu.
The expected output is: **64**.

### 1.3 Check for internet connection

`$ ping -c 5 archlinux.org`

this will run 5 pings to the archlinux page to ensure that you got a working internet connection.
There should be no problems when running a LAN connection, for WIFI check out [iwd](https://wiki.archlinux.org/title/Iwd#iwctl).
If this doesn't work check out the [1.7 Connect to the internet](https://wiki.archlinux.org/title/Installation_guide) section.

### 1.4 Update the system clock

`$ timedatectl`

### 1.5 Partition the disk

`$ cfdisk`
_Choose GPT for EFI Setup_

Create **3** Partitions:

1. 512MB for [EFI](https://wiki.archlinux.org/title/EFI_system_partition)
2. ~GB for [SWAP](https://wiki.archlinux.org/title/Swap) (only if you want to use SWAP, you can also set up a SWAP file later.)
3. ~GB for Root Partition

_**Write Partitions to the drive.**_

`$ lsblk`  
_Check your current block devices and make sure all partitions are there_  
**It should show the three partitions called as parts of the main drive device**

`$ mkfs.ext4 /dev/>Root Partition Name<`  
**Formats the root partition to ext4**

`$ mkfs.fat -F 32 /dev/>EFI Partition Name<`  
**Formats the EFI partition to fat32**

`$ mkswap /dev/>SWAP Partition Name<`  
**Formats the SWAP partition to SWAP**

### # Mounting the disk partitions

`$ mount /dev/>Root Partition< /mnt`  
Mounts the partition to the default /mnt path.

`$ mkdir -p /mnt/boot/efi`  
`$ mount /dev/>EFI Partition< /mnt/boot/efi`  
Creates the necessary boot directory and mounts the efi partition there.

`$ swapon /dev/>SWAP Partition<`  
Turns on SWAP with the given partition.

# 2 Running system Installation

`$ pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager`  
this installs the **base archlinux**, a firmware for newer soundcards, **base-devel** for compiling/installing/packaging,
**grub and efibootmgr** for using grub with efi as boot management, **nano** as a basic text editor and
**networkmanager** for managing the systems network connection.

# 3 Configuring the system

### 3.1 Running fstab

`$ genfstab /mnt`  
Generates and fstab file, check if mounted drives show up as expected.  
`$ genfstab /mnt > /mnt/etc/fstab`  
Generated an fstab file and puts it in the fstab directory.  
`$ cat /mnt/etc/fstab`  
Check if everything was generated correctly.

### 3.2 Root into the new system

`$ arch-chroot /mnt`  
Changes to root user in the new arch install.

### 3.4 Set time zone

`$ ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime`  
Set the timezone to Europe Berlin.  
`$ hwclock --systohc`  
Generates and sets the hardware clock to the timezone set before.

### 3.5 Set Localization

`$ nano /etc/locale.gen`  
**Uncomment** the line where it says de_DE.UTF-8.  
`$ locale-gen`  
Generates the locales uncommented before.  
`$ nano /etc/locale.conf`
type in:

> LANG=de_DE.UTF-8

then save and exit.

`$ nano /etc/vconsole.conf`

make the keyboard layout change persistent by typing :

> KEYMAP=de-latin1
> XKBMAP=de

in this file, save and exit.

### 3.6 Set Hostname

Create a hostname file:

`$ nano /etc/hostname`

and put

> yourDesiredHostnameAsOneWord

in it, save and exit.

### 3.7 Set root password

set a your root password by typing and enter :

`$ passwd`

### 3.8 Create a sudo User

To create a new User (and add it to the wheel group needed for sudo commands):

`$ useradd -m -G wheel -s /bin/bash susurmi`

then set a password by entering :

`$ passwd susurmi`

then activate sudo commands for the wheel group by :

`$ EDITOR=nano visudo`

and then uncommenting the line:

> %wheel ALL=(ALL) ALL

then save and exit.

### 3.9 Enabling system core services

Type :

`$ systemctl enable NetworkManager`

this enables the **networkmanager** package downloaded earlier to manage network connections.

# 4. Setting up grub as boot loader

Install grub by :

`$ grub-install /dev/yourmaindisk`

your main disk is the head label of the disk formatted earlier (something like sda or nvme0n1).  
Then create a config file by running:

`$ grub-mkconfig -o /boot/grub/grub.cfg`

# 5. Unmount and system reboot

`$ exit`

to exit out of the arch-chroot and then

`$ umount -R /mnt`

to unmount all drives that are curently not busy and then reboot the system by typing:

`$ reboot`

You also might wanna make sure that you change your boot priorities to boot directly of your disk and not of the flash drive.
