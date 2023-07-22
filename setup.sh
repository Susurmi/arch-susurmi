#!/bin/bash

username=$SUDO_USER

# Update System
pacman -Syu --noconfirm

# Get needed base dependencies
pacman -S --noconfirm git wget vim kitty

# Get xorg packages
pacman -S --noconfirm xorg xorg-server xorg-xinit xdg-user-dirs libx11 libxinerama libxft webkit2gtk

# Install Rofi, Picom and feh
pacman -S --noconfirm rofi picom feh

# Install fonts
pacman -S --noconfirm ttf-joypixels terminus-font ttf-font-awesome

# Copy bashrc and load it
cp dotfiles/.bashrc ~/.bashrc
source

# Install YAY
su -c 'mkdir -p /home/$username/Downloads && cd /home/$username/Downloads && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si' $username
su -c 'yay -Y --gendb && yay-Syu --devel && yay -Syu --devel' $username

su -c 'xdg-user-dirs-update' $username

# Install Brave Browser / VS-Codium
su -c 'yay -S --noconfirm brave-bin && yay -S --noconfirm vscodium-bin' $username

# Get/Set Wallpaper
su -c 'wget -P /home/$username/Bilder -O wallpaper.png https://w.wallhaven.cc/full/9m/wallhaven-9mjoy1.png && feh --bg-fill /home/$username/Bilder/wallpaper.png' $username

# Install ly as login manager
pacman -S --noconfirm ly
systemctl enable ly.service
systemctl disable getty@tty2.service

# Audio 
pacman -S --noconfirm pipewire pipewire-pulse pipewire-alsa wireplumber
su -c 'systemctl --user --now enable pipewire pipewire-pulse wireplumber' $username