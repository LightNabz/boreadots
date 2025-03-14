#!/bin/bash

THEME_DIR="$HOME/.config/waybar/themes"
CURRENT_THEME=$(basename "$(readlink ~/.config/waybar/style.css)" | cut -d'/' -f1)

# Select theme with Rofi
SELECTED_THEME=$(ls "$THEME_DIR" | rofi -dmenu -p "Select Waybar Theme:")

# If the user cancels, exit
if [ -z "$SELECTED_THEME" ]; then
    exit 0
fi

# Apply the selected theme (both config and style.css)
ln -sf "$THEME_DIR/$SELECTED_THEME/config" ~/.config/waybar/config
ln -sf "$THEME_DIR/$SELECTED_THEME/style.css" ~/.config/waybar/style.css
bash ~/.config/hypr/scripts/waybar-reload.sh  # Reload Waybar

notify-send "Waybar Theme" "Switched to $SELECTED_THEME"

