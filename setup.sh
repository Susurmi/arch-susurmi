#!/bin/sh

# Check if the script is running with superuser privileges
if [ "$EUID" -ne 0 ]; then
  echo "This script requires superuser privileges. Please run it with sudo."
  exit 1
fi

# Exit immediately if any command returns a non-zero status
set -e

# needed vars
username=$SUDO_USER
folderpath=$(realpath .)

# Validate if the username exists and is valid
if ! id "$username" &>/dev/null; then
  echo "Invalid username: $username"
  exit 1
fi

# Function to echo colored text
print_color() {
  local color="$1"
  local text="$2"
  echo -e "\033[${color}m${text}\033[0m"
}

# The ASCII art
ascii_art="
# Created by 
#  ███████╗██╗   ██╗███████╗██╗   ██╗██████╗ ███╗   ███╗██╗
#  ██╔════╝██║   ██║██╔════╝██║   ██║██╔══██╗████╗ ████║██║
#  ███████╗██║   ██║███████╗██║   ██║██████╔╝██╔████╔██║██║
#  ╚════██║██║   ██║╚════██║██║   ██║██╔══██╗██║╚██╔╝██║██║
#  ███████║╚██████╔╝███████║╚██████╔╝██║  ██║██║ ╚═╝ ██║██║
#  ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝
# https://github.com/susurmi
"

# Display the colored ASCII art
print_color "31;1" "$ascii_art"
sleep 2

# Update Pkg Db and upgrade System
pacman -Syu --noconfirm

# Get needed base packages
pacman -S --noconfirm wget vim kitty

# Get xorg/libx11 packages
pacman -S --noconfirm xorg xorg-server xorg-xinit xdg-user-dirs libx11 libxinerama libxft webkit2gtk

# Install Rofi, Picom and feh
pacman -S --noconfirm rofi picom feh

# Install fonts
pacman -S --noconfirm ttf-joypixels terminus-font ttf-font-awesome

# Generate user folders
su -c 'xdg-user-dirs-update' $username

# Copy bashrc and load it
cp "$folderpath/dotfiles/.bashrc" "/home/$username/.bashrc" && \
su -c "source /home/$username/.bashrc" "$username"

# Get/Set Wallpaper
su -c 'wget -P /home/$username/Bilder -O wallpaper.png https://w.wallhaven.cc/full/9m/wallhaven-9mjoy1.png' $username && \
touch "/home/$username/.fehbg" && \
cp "$folderpath/dotfiles/.fehbg" "/home/$username/.fehbg"

# Install ly as login manager
pacman -S --noconfirm ly && \
systemctl enable ly.service && \
systemctl disable getty@tty2.service

# Audio 
pacman -S --noconfirm pipewire pipewire-pulse pipewire-alsa wireplumber && \
su -c 'systemctl enable pipewire pipewire-pulse wireplumber' $username


# Created by 
#  ███████╗██╗   ██╗███████╗██╗   ██╗██████╗ ███╗   ███╗██╗
#  ██╔════╝██║   ██║██╔════╝██║   ██║██╔══██╗████╗ ████║██║
#  ███████╗██║   ██║███████╗██║   ██║██████╔╝██╔████╔██║██║
#  ╚════██║██║   ██║╚════██║██║   ██║██╔══██╗██║╚██╔╝██║██║
#  ███████║╚██████╔╝███████║╚██████╔╝██║  ██║██║ ╚═╝ ██║██║
#  ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝
# https://github.com/susurmi