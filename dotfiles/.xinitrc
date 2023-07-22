#!/bin/bash

#source for the terminal
xrdb -merge $HOME/.xres &

# set and reload fonts
xset fp+ $HOME/.fonts &
xset fp rehash &

# set keyboard layout 
setxkbmap de &

# set resolution and wallpaper
#xrandr --output "" --mode 1920x1080 &
~/.fehbg &

#start picom and dwm
picom &
#dwmblocks &
exec dwm