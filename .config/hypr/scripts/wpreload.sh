#!/bin/bash

# Kill the current Hyprpaper instance
pkill hyprpaper

# Restart Hyprpaper
hyprpaper &

# Update the hyprlock
bash ~/.config/hypr/scripts/wallnprofilefetch.sh

# Send a notification
notify-send "Hyprpaper Reloaded" "Your wallpaper has been refreshed successfully!" -i preferences-desktop-wallpaper

