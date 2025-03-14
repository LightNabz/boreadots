#!/bin/bash

MENU_STATE_FILE="/tmp/waybar_menu_state"

if [ -f "$MENU_STATE_FILE" ]; then
    rm "$MENU_STATE_FILE"  # Hide menu
    echo '{"text": "  Menu"}'
else
    touch "$MENU_STATE_FILE"  # Show menu
    echo '{"text": "  Menu (Open)"}'
fi


