#!/bin/bash

CONFIG="$HOME/.config/hypr/hyprpaper.conf"
DEFAULT_WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER_DIR_FILE="$HOME/.config/hypr/wallpaper_dir"  # Store last used directory
RELOAD_SCRIPT="$HOME/.config/hypr/scripts/wpreload.sh"  # Hyprpaper reload script

# Load last used wallpaper directory or default
if [[ -f "$WALLPAPER_DIR_FILE" ]]; then
    WALLPAPER_DIR=$(cat "$WALLPAPER_DIR_FILE")
else
    WALLPAPER_DIR="$DEFAULT_WALLPAPER_DIR"
fi

# Function to pick a new wallpaper directory
pick_wallpaper_dir() {
    NEW_DIR=$(zenity --file-selection --directory --title="Select Wallpaper Directory")
    
    if [[ -n "$NEW_DIR" ]]; then
        echo "$NEW_DIR" > "$WALLPAPER_DIR_FILE"  # Save new directory
        WALLPAPER_DIR="$NEW_DIR"
    else
        exit 0  # Abort if no selection
    fi
}

# Rofi menu
CHOICE=$(echo -e "Change Wallpaper Directory\nSelect Wallpaper\nRefresh Hyprpaper" | rofi -dmenu -i -p "Choose Action" -no-fixed-num-lines -theme-str 'inputbar { enabled: false; }')

# Handle user choice
case "$CHOICE" in
    "Change Wallpaper Directory")
        pick_wallpaper_dir  # Select directory
        ;;  # Continue to wallpaper selection automatically
    "Refresh Hyprpaper")
        bash "$RELOAD_SCRIPT"
        exit 0
        ;;
    "Select Wallpaper")
        ;;
    *)
        exit 0  # Abort if nothing selected
        ;;
esac

# Ensure the wallpaper directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
    echo "Wallpaper directory not found: $WALLPAPER_DIR"
    exit 1
fi

# Get list of wallpapers
WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -exec basename {} \;)

# Check if wallpapers exist
if [[ -z "$WALLPAPERS" ]]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Use Rofi to select a wallpaper with image previews
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | while read -r file; do
    echo -en "$(basename "$file")\0icon\x1f$file\n"
done | rofi -dmenu -i -p "Select Wallpaper")

# Check if user canceled selection
if [[ -z "$SELECTED_WALLPAPER" ]]; then
    echo "No wallpaper selected."
    exit 1
fi

# Reconstruct full path
SELECTED_WALLPAPER_PATH=$(realpath "$WALLPAPER_DIR/$SELECTED_WALLPAPER")

# Get primary monitor dynamically
PRIMARY_MONITOR=$(hyprctl monitors | awk 'NR==1 {print $2}')

# Update hyprpaper.conf
echo "preload = $SELECTED_WALLPAPER_PATH" > "$CONFIG"
echo "wallpaper = $PRIMARY_MONITOR, $SELECTED_WALLPAPER_PATH" >> "$CONFIG"

# Reload hyprpaper
bash "$RELOAD_SCRIPT"

echo "Wallpaper updated to: $SELECTED_WALLPAPER_PATH"






