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

# Validate if the username exists and is valid
if ! id "$username" &>/dev/null; then
  echo "Invalid username: $username"
  exit 1
fi

# Update System
pacman -Syu --noconfirm

# Get needed base packages
pacman -S --noconfirm git wget vim kitty

# Get xorg/libx11 packages
pacman -S --noconfirm xorg xorg-server xorg-xinit xdg-user-dirs libx11 libxinerama libxft webkit2gtk

# Install Rofi, Picom and feh
pacman -S --noconfirm rofi picom feh

# Install fonts
pacman -S --noconfirm ttf-joypixels terminus-font ttf-font-awesome

# Copy bashrc and load it
cp dotfiles/.bashrc ~/.bashrc && \
source ~/.bashrc

# Install YAY
su -c 'mkdir -p /home/$username/Downloads && cd /home/$username/Downloads && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si' $username && \
su -c 'yay -Y --gendb && yay -Syu --devel && yay -Syu --devel' $username

su -c 'xdg-user-dirs-update' $username

# Install Brave Browser / VS-Codium
yay -S --noconfirm brave-bin vscodium-bin

# Get/Set Wallpaper
su -c 'wget -P /home/$username/Bilder -O wallpaper.png https://w.wallhaven.cc/full/9m/wallhaven-9mjoy1.png' $username

# Install ly as login manager
pacman -S --noconfirm ly && \
systemctl enable ly.service && \
systemctl disable getty@tty2.service

# Audio 
pacman -S --noconfirm pipewire pipewire-pulse pipewire-alsa wireplumber && \
su -c 'systemctl --user --now enable pipewire pipewire-pulse wireplumber' $username