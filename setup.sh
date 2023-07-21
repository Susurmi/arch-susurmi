#!/bin/bash

username=$SUDO_USER

# Update System
pacman -Syu --noconfirm

# Get needed base dependencies
pacman -S --noconfirm git wget vim kitty

# Get xorg packages
pacman -S --noconfirm xorg xorg-server xorg-xinit xdg-utils libx11 libxinerama libxft webkit2gtk

# Install Rofi, Picom and feh
pacman -S --noconfirm rofi picom feh

# Install fonts
pacman -S --noconfirm ttf-joypixels terminus-font ttf-font-awesome

# Install YAY
su -c 'mkdir -p /home/$ROOT_USER/Downloads && cd /home/$ROOT_USER/Downloads && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si' $username

# Install Brave Browser / VS-Codium
su -c 'yay -S --noconfirm brave-bin && yay -S --noconfirm vscodium-bin' $username

# Get/Set Wallpaper
su -c 'wget -P /home/$SUDO_USER/Bilder -O wallpaper.png https://w.wallhaven.cc/full/9m/wallhaven-9mjoy1.png && feh --bg-fill /home/$SUDO_USER/Bilder/wallpaper.png' $username