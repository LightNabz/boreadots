#!/bin/bash

CONFIG="$HOME/.config/hypr/hyprprofile.conf"
DEFAULT_PIC_DIR="$HOME/Pictures/ProfilePics"
PROFILE_PIC_DIR_FILE="$HOME/.config/hypr/profile_pic_dir"  # Store last used directory
RELOAD_SCRIPT="$HOME/.config/hypr/scripts/profile-reload.sh"  # Profile picture reload script

# Load last used profile picture directory or default
if [[ -f "$PROFILE_PIC_DIR_FILE" ]]; then
    PROFILE_PIC_DIR=$(cat "$PROFILE_PIC_DIR_FILE")
else
    PROFILE_PIC_DIR="$DEFAULT_PIC_DIR"
fi

# Function to pick a new profile picture directory
pick_profile_pic_dir() {
    NEW_DIR=$(zenity --file-selection --directory --title="Select Profile Picture Directory")
    
    if [[ -n "$NEW_DIR" ]]; then
        echo "$NEW_DIR" > "$PROFILE_PIC_DIR_FILE"  # Save new directory
        PROFILE_PIC_DIR="$NEW_DIR"
    else
        exit 0  # Abort if no selection
    fi
}

# Rofi menu
CHOICE=$(echo -e "Change Profile Picture Directory\nSelect Profile Picture\nRefresh Profile Picture" | rofi -dmenu -i -p "Choose Action" -no-fixed-num-lines -theme-str 'inputbar { enabled: false; }')

# Handle user choice
case "$CHOICE" in
    "Change Profile Picture Directory")
        pick_profile_pic_dir  # Select directory
        ;;  # Continue to profile picture selection automatically
    "Refresh Profile Picture")
        bash "$RELOAD_SCRIPT"
        exit 0
        ;;
    "Select Profile Picture")
        ;;
    *)
        exit 0  # Abort if nothing selected
        ;;
esac

# Ensure the profile picture directory exists
if [[ ! -d "$PROFILE_PIC_DIR" ]]; then
    echo "Profile picture directory not found: $PROFILE_PIC_DIR"
    exit 1
fi

# Get list of profile pictures
PROFILE_PICS=$(find "$PROFILE_PIC_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -exec basename {} \;)

# Check if profile pictures exist
if [[ -z "$PROFILE_PICS" ]]; then
    echo "No profile pictures found in $PROFILE_PIC_DIR"
    exit 1
fi

# Use Rofi to select a profile picture with image previews
SELECTED_PIC=$(find "$PROFILE_PIC_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | while read -r file; do
    echo -en "$(basename "$file")\0icon\x1f$file\n"
done | rofi -dmenu -i -p "Select Profile Picture")

# Check if user canceled selection
if [[ -z "$SELECTED_PIC" ]]; then
    echo "No profile picture selected."
    exit 1
fi

# Reconstruct full path
SELECTED_PIC_PATH=$(realpath "$PROFILE_PIC_DIR/$SELECTED_PIC")

# Update hyprprofile.conf
echo "profile_pic = $SELECTED_PIC_PATH" > "$CONFIG"

# Reload profile picture
bash "$RELOAD_SCRIPT"

echo "Profile picture updated to: $SELECTED_PIC_PATH"

