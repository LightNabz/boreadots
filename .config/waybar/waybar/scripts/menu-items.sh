#!/bin/bash

MENU_STATE_FILE="/tmp/waybar_menu_state"

if [ -f "$MENU_STATE_FILE" ]; then
    echo '{"text": " 󰸉 ", "class": "visible"}'
else
    echo '{"text": "", "class": "hidden"}'
fi

