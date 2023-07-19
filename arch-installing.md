# Pre Installation

Prepare Installation media :  
https://archlinux.org/download/  
<br>

# Boot the live environment

### # Set the console keyboard layout

`loadkeys de-latin1`  
_this one loads the german qwertz keyboard layout_<br><br>

### # Verify the boot mode

`cat /sys/firmware/efi/fw_platform_size`<br>
_expected output: 64_<br><br>

### # Check for internet connection

`ping -c 5 archlinux.org`<br><br>

### # Update the system clock

`timedatectl`<br><br>

### # Partition the disk

`cfdisk`  
_Choose GPT for EFI Setup_
<br><br>
Create **3** Partitions:

1. 512MB for EFI
2. ~GB for SWAP
3. ~GB for Root Partition

_**Write Partitions to the drive.**_

`lsblk`  
_Check your current block devices and make sure all partitions are there_  
**It should show the three partitions called as parts of the main drive device**

`mkfs.ext4 /dev/>Root Partition Name<`  
**Formats the root partition to ext4**<br><br>

`mkfs.fat -F 32 /dev/>EFI Partition Name<`  
**Formats the EFI partition to fat32**<br><br>

`mkswap /dev/>SWAP Partition Name<`  
**Formats the SWAP partition to SWAP**<br><br>

### # Mounting the disk partitions

`mount /dev/>Root Partition< /mnt`  
Mounts the partition to the default /mnt path.

`mkdir -p /mnt/boot/efi`  
`mount /dev/>EFI Partition< /mnt/boot/efi`  
Creates the necessary boot directory and mounts the efi partition there.

`swapon /dev/>SWAP Partition<`  
Turns on SWAP with the given partition.<br><br>

# # Running system Installation

`pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager`  
this installs the **base archlinux**, a firmware for newer soundcards, **base-devel** for compiling, <br>**grub and efibootmgr** for using grub with efi as boot management, **nano** as a basic text editor <br>and **networkmanager** for managing internet connection.

# # Configuring the system

### # Running fstab

`genfstab /mnt`  
Generates and fstab file, check if mounted drives show up as expected.  
`genfstab /mnt > /mnt/etc/fstab`  
Generated an fstab file and puts it in the fstab directory.  
`cat /mnt/etc/fstab`  
Check if everything was generated correctly.

### # Root into the new system

`arch-chroot /mnt`  
Changes to root user in the new arch install.

### # Set time zone

`ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime`  
Set the timezone to Europe Berlin.  
`hwclock --systohc`  
Generates and sets the hardware clock to the timezone set before.

### # Set Localization

`nano /etc/locale.gen`  
**Uncomment** the line where it says de_DE.UTF-8.  
`locale-gen`  
Generates the locales uncommented before.  
`nano /etc/locale.conf`
type in:

> LANG=de_DE.UTF-8

then save and exit.

`nano /etc/vconsole.conf`

make the keyboard layout change persistent by typing :

> KEYMAP=de-latin1

in this file, save and exit.

### # Set Hostname

Create a hostname file:

`nano /etc/hostname`

and put

> yourDesiredHostnameAsOneWord

in it, save and exit.

### # Set root password

set a your root password by typing and enter :

`passwd`

### # Create a sudo User

To create a new User (and add it to the wheel group needed for sudo commands):

`useradd -m -G wheel -s /bin/bash susurmi`

then set a password by entering :

`passwd susurmi`

then activate sudo commands for the wheel group by :

`EDITOR=nano visudo`

and then uncommenting the line:

> %wheel ALL=(ALL) ALL

then save and exit.

### # Enabling system core services

Type :

`systemctl enable NetworkManager`

this enables the **networkmanager** package downloaded earlier to manage network connections.

### # Setting up grub as boot loader

Install grub by :

`grub-install /dev/yourmaindisk`

your main disk is the head label of the disk formatted earlier (something like sda or nvme0n1).  
Then create a config file by running:

`grub-mkconfig -o /boot/grub/grub.cfg`

### Unmount all buys drives and boot in to the new install

´unmount -R /mnt`

to unmount all drives that are not busy an then reboot by typing:

`reboot`
