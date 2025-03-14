#!/bin/bash

# Rofi settings menu with icons
chosen=$(echo -e " Change Wallpaper\n Reload Waybar\n Game Mode" | rofi -dmenu -p "Settings" -theme-str 'listview { lines: 10; }' -icon-theme "Papirus" -show-icons)

case $chosen in
    " Change Wallpaper")
        # Launch the wallpaper script
        ~/.config/hypr/scripts/wallpaper.sh
        ;;
    " Reload Waybar")
        # Reload the Waybar script
        ~/.config/hypr/scripts/waybar-reload.sh
        ;;
    " Game Mode")
        # Literally just disable some shi
        ~/.config/hypr/scripts/game-toggle.sh
        ;; 
    *)
        # Exit if nothing is chosen
        exit 1
        ;;
esac



