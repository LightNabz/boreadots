#!/bin/bash

LAST_TITLE=""

declare -A ICONS=(
    ["firefox"]=" "       # Firefox
    ["chromium"]=" "      # Chromium-based browsers
    ["google-chrome"]=" "
    ["brave-browser"]=" "
    ["zen"]=" "
    ["libreoffice"]=" "   # LibreOffice
    ["kitty"]=" "         # Kitty Terminal
    ["alacritty"]=" "     # Alacritty Terminal
    ["wezterm"]=" "       # WezTerm
    ["code"]=" "          # VS Code
    ["discord"]=" "       # Discord
    ["steam"]=" "         # Steam
    ["thunar"]=" "        # Thunar File Manager
    ["nautilus"]=" "      # Nautilus File Manager
    ["nemo"]=" "          # Nemo File Manager
    ["mpv"]=" "           # MPV Media Player
    ["vlc"]="嗢 "          # VLC
)

while true; do
    # Get window title and class
    WINDOW_INFO=$(hyprctl activewindow -j 2>/dev/null)
    TITLE=$(echo "$WINDOW_INFO" | jq -r '.title' 2>/dev/null)
    CLASS=$(echo "$WINDOW_INFO" | jq -r '.class' 2>/dev/null)

    # Handle null/empty values
    if [[ -z "$TITLE" || "$TITLE" == "null" ]]; then
        TITLE=""
    fi
    if [[ -z "$CLASS" || "$CLASS" == "null" ]]; then
        CLASS=""
    fi

    # Get icon (default: generic window icon)
    ICON=${ICONS[$CLASS]:-""}

    # Format output with icon
    if [[ -z "$TITLE" ]]; then
        DISPLAY_TEXT=""
    else
        DISPLAY_TEXT="$ICON $TITLE"
    fi

    # Only update if text changes
    if [[ "$DISPLAY_TEXT" != "$LAST_TITLE" ]]; then
        echo "{\"text\": \"$DISPLAY_TEXT\", \"tooltip\": \"$TITLE\"}"
        LAST_TITLE="$DISPLAY_TEXT"
    fi

    sleep 0.5
done



