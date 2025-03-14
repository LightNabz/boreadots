#!/bin/bash

# Screenshot directory
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Prompt user for screenshot type
CHOICE=$(echo -e "Selection\nEntire Screen" | rofi -dmenu -p "Choose screenshot type" -no-fixed-num-lines -theme-str 'inputbar { enabled: false; }')

# Exit if user presses ESC or closes the menu
[ -z "$CHOICE" ] && notify-send "Screenshot cancelled" && exit 1

# Wait for rofi to close before taking a screenshot
sleep 0.5

# Determine filename
FILENAME="$SCREENSHOT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"

# Take screenshot
if [[ "$CHOICE" == "Selection" ]]; then
    grim -g "$(slurp)" "$FILENAME"
elif [[ "$CHOICE" == "Entire Screen" ]]; then
    sleep 0.5  # Small delay to ensure rofi is closed
    grim "$FILENAME"
else
    notify-send "Screenshot cancelled" && exit 1
fi

# Prompt for action
ACTION=$(echo -e "Copy\nSave\nCopy & Save" | rofi -dmenu -p "What to do with the screenshot?" -no-fixed-num-lines -theme-str 'inputbar { enabled: false; }')

# Exit if user presses ESC or closes the menu
[ -z "$ACTION" ] && rm "$FILENAME" && notify-send "Screenshot discarded" && exit 1

if [[ "$ACTION" == "Copy" ]]; then
    wl-copy < "$FILENAME"
    rm "$FILENAME"
elif [[ "$ACTION" == "Save" ]]; then
    notify-send "Screenshot saved to $FILENAME"
elif [[ "$ACTION" == "Copy & Save" ]]; then
    wl-copy < "$FILENAME"
    notify-send "Screenshot copied and saved to $FILENAME"
else
    rm "$FILENAME"
    notify-send "Screenshot discarded"
fi



