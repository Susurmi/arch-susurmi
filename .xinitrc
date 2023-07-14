
#!/bin/bash

#source for the terminal
xrdb -merge $HOME/.xres &

# font
xset fp+ $HOME/.fonts &
xset fp rehash &

# set keyboard layout 
setxkbmap de &

# resolution and wallpaper
#xrandr --output "" --mode 1920x1080 &
~/.fehbg &

#start dwm
picom &
dwmblocks &
exec dwm