#!/bin/bash
# Stop any running Waybar instances
pkill waybar

notify-send "Restarting Waybar..." -u low -t 1000

# Wait a bit to make sure it fully closes
sleep 0.5

# Restart Waybar
waybar &

