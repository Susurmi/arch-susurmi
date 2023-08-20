#!/bin/sh

# run function i found in arcolinux qtile config
# https://github.com/arcolinux/arcolinux-qtile/blob/master/etc/skel/.config/qtile/scripts/autostart.sh
# checks if the service is already running if not starts it

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

# Define german keyboard layout
setxkbmap de &

# Set screen resolution
xrandr --output DP-1 --mode 1920x1080
xrandr --output HDMI-1 --mode 1920x1080 --left-of DP-1

# set wallpaper
feh --no-fehbg --bg-fill '/home/alex/Bilder/wallpapers/wallpaper.png' 

# starting utility applications at boot
/usr/bin/lxpolkit &
dunst &
picom &

discord --start-minimized &
steam -silent & 