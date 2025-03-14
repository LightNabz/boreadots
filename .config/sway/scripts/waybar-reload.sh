#!/bin/bash
pkill waybar
sleep 0.5
WAYLAND_DISPLAY=wayland-1 waybar &
