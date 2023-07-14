# Get nedded base dependencies
sudo pacman -Syu git wget vim kitty neofetch wget

# Get minimal xorg setup
sudo pacman -S xorg xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk

# Install Rofi, Picom and feh
pacman -S rofi picom feh

# Install fonts
pacman -S ttf-joypixels terminus-font