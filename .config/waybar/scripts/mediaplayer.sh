#!/bin/bash

# Get player status
STATUS=$(playerctl status 2>/dev/null)
MEDIA_INFO=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)
ICON=""  # Default stop icon

# Set the appropriate icon
if [[ "$STATUS" == "Playing" ]]; then
    ICON=""
elif [[ "$STATUS" == "Paused" ]]; then
    ICON=""
fi

# If no media info, show fallback text
if [[ -z "$MEDIA_INFO" ]]; then
    echo "$ICON No media playing"
    exit
fi

# Scrolling configuration
MAX_LENGTH=40  # Visible characters
SCROLL_STEP=2  # Characters to shift per update
SCROLL_FILE="/tmp/waybar_mediaplayer_scroll"  # Track scroll position

# Get or reset scroll position
if [[ ! -f "$SCROLL_FILE" ]]; then
    echo 0 > "$SCROLL_FILE"
fi
SCROLL_POS=$(cat "$SCROLL_FILE")

# If the text is short, display it fully and reset scrolling
if [[ ${#MEDIA_INFO} -le $MAX_LENGTH ]]; then
    echo "$ICON $MEDIA_INFO"
    echo 0 > "$SCROLL_FILE"
    exit
fi

# Create looped scrolling text
SCROLL_TEXT="   $MEDIA_INFO • $MEDIA_INFO • $MEDIA_INFO   "
DISPLAY_TEXT="${SCROLL_TEXT:$SCROLL_POS:$MAX_LENGTH}"

# Update scroll position
SCROLL_POS=$((SCROLL_POS + SCROLL_STEP))
if [[ $SCROLL_POS -ge ${#SCROLL_TEXT} ]]; then
    SCROLL_POS=0
fi
echo "$SCROLL_POS" > "$SCROLL_FILE"

# Output for Waybar
echo "$ICON $DISPLAY_TEXT"


