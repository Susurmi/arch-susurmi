# Get needed base dependencies
sudo pacman -Syu --noconfirm git wget vim kitty neofetch

# Get xorg packages
sudo pacman -S --noconfirm xorg xorg-server xorg-xinit xdg-utils libx11 libxinerama libxft webkit2gtk

# Install Rofi, Picom and feh
pacman -S --noconfirm rofi picom feh

# Install fonts
pacman -S --noconfirm ttf-joypixels terminus-font ttf-font-awesome

# Install YAY
mkdir -p /home/$ROOT_USER/Downloads
cd /home/$ROOT_USER/Downloads
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install Brave Browser
yay -S --noconfirm brave-bin

# Get/Set Wallpaper
wget -P /home/$SUDO_USER/Bilder -O wallpaper.png https://w.wallhaven.cc/full/9m/wallhaven-9mjoy1.png
feh --bg-fill /home/$SUDO_USER/Bilder/wallpaper.png