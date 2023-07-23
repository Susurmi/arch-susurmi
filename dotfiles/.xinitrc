#!/bin/bash

#source for the terminal
xrdb -merge $HOME/.xres &

# set and reload fonts
xset fp+ $HOME/.fonts &
xset fp rehash &

# set keyboard layout 
setxkbmap de &

# set resolution and wallpaper
xrandr --output "Virtual-1" --mode 1920x1080 &
feh --no-fehbg --bg-fill /home/$USER/Bilder/wallpaper.png &

#start picom and dwm
picom &
#dwmblocks &
exec dwm