#!/bin/bash

# Set user variable
USER=$(whoami)

# Fetch and copy user avatar
ICON_SRC="/var/lib/AccountsService/icons/$USER"
ICON_DEST="$HOME/.face"

if [[ -f "$ICON_SRC" ]]; then
    cp "$ICON_SRC" "$ICON_DEST"
    echo "User icon copied to $ICON_DEST"
else
    echo "User icon not found at $ICON_SRC"
fi

# Fetch wallpaper path from hyprpaper.conf
HYPERPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
WALLPAPER_DEST="$HOME/.config/background"

if [[ -f "$HYPERPAPER_CONF" ]]; then
    WALLPAPER=$(grep 'wallpaper =' "$HYPERPAPER_CONF" | cut -d ',' -f2 | tr -d ' ')
    
    if [[ -f "$WALLPAPER" ]]; then
        cp "$WALLPAPER" "$WALLPAPER_DEST"
        echo "Wallpaper copied to $WALLPAPER_DEST"
    else
        echo "Wallpaper file not found: $WALLPAPER"
    fi
else
    echo "Hyprpaper config not found at $HYPERPAPER_CONF"
fi



