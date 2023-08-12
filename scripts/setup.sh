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
sleep 1

# Update Pkg Db and upgrade System
pacman -Syu --noconfirm

# Get needed base packages
pacman -S --noconfirm wget vim kitty firefox go

# Get xorg/libx11 packages
pacman -S --noconfirm xorg xorg-server xorg-xinit xdg-user-dirs libx11 gtk3

# Install Rofi, Picom, feh, thunar
pacman -S --noconfirm rofi picom feh thunar

# Install fonts
pacman -S --noconfirm ttf-joypixels terminus-font ttf-font-awesome ttf-liberation

# Generate user folders
su -c 'xdg-user-dirs-update' $username

# Copy bashrc and load it
cp "$folderpath/dotfiles/.bashrc" "/home/$username/.bashrc" && \
su -c "source /home/$username/.bashrc" "$username"

# Copy kitty.conf
mkdir -p /home/$username/.config/kitty && \
cp $folderpath/dotconfig/kitty/kitty.conf /home/$username/.config/kitty/

# Copy rofi theme
mkdir -p /home/$username/.config/rofi && \
cp $folderpath/dotconfig/rofi/config.rasi /home/$username/.config/rofi/

# Get/Set Wallpaper
su -c "wget -O wallpaper.png https://w.wallhaven.cc/full/p9/wallhaven-p97l5e.png" $username && \
mv "$folderpath/wallpaper.png" "/home/$username/Bilder" && \

# Install ly as login manager
pacman -S --noconfirm ly && \
systemctl enable ly.service && \
systemctl disable getty@tty2.service

# Install Qtile
pacman -S --noconfirm qtile && \
mkdir -p /home/$username/.config/qtile && \
cp -r $folderpath/dotconfig/qtile /home/$username/.config/

# Audio 
pacman -S --noconfirm pipewire pipewire-pulse pipewire-alsa wireplumber && \
#su -c "systemctl --user enable pipewire pipewire-pulse wireplumber" $username