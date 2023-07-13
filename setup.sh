# Get nedded base dependencies
sudo pacman -Syu git wget vim kitty

# Get minimal xorg setup
sudo pacman -S xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk

# Install Rofi and Picom
pacman -S rofi picom