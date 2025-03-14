#!/bin/bash

# Get the current animation state (0 = disabled, 1 = enabled)
ANIMATION_STATE=$(hyprctl getoption animations:enabled | awk '/int:/ {print $2}')

if [[ "$ANIMATION_STATE" -eq 0 ]]; then
    echo "Game Mode is currently ENABLED, switching to normal mode..."
    notify-send "Game Mode Disabled" "Returning to normal mode" -u normal -t 1500
    ~/.config/hypr/scripts/gamescripts/game-disable.sh
else
    echo "Game Mode is currently DISABLED, switching to game mode..."
    notify-send "Game Mode Enabled" "Entering game mode" -u normal -t 1500
    ~/.config/hypr/scripts/gamescripts/game-enable.sh
fi
