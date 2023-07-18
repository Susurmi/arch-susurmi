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

`mkdir -p /mnt/boot`  
`mount /dev/>EFI Partition< /mnt/boot`  
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
