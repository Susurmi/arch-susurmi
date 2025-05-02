#!/bin/bash

xrandr --output DP-1 --primary --mode 3440x1440 --rate 144 --pos 2160x1093 --rotate normal --output DP-2 --mode 3840x2160 --rate 60 --pos 0x0 --rotate right --output HDMI-1 --off --output HDMI-2 --off

picom &
nitrogen --restore
conky &
dunst &
/usr/bin/lxqt-policykit-agent &

#discord --start-minimized
#steam -silent

xsetroot -cursor_name left_ptr

# Verhindert, dass der Bildschirm in den Ruhezustand geht
xset s off          # Deaktiviert den Bildschirmschoner
xset -dpms          # Deaktiviert die Energieverwaltung
xset s noblank      # Verhindert das Schwarzwerden des Bildschirms
