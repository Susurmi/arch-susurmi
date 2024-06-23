#!/bin/bash
# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
killall waybar
pkill waybar
sleep 0.2
# Start Waybar with my configs
waybar -c /home/alex/.config/waybar/config.jsonc -s /home/alex/.config/waybar/style.css &