#!/bin/bash

echo "Enabling Game Mode..."

# Disable Hyprland effects for better performance
hyprctl keyword decoration:blur:enabled false 2>/dev/null && echo "Blur disabled"
hyprctl keyword decoration:shadow:enabled false 2>/dev/null && echo "Shadows disabled"
hyprctl keyword animations:enabled false 2>/dev/null && echo "Animations disabled"
hyprctl keyword general:layout master 2>/dev/null && echo "Layout set to Master"
hyprctl keyword general:allow_tearing true 2>/dev/null && echo "Tearing allowed"

# Ensure refresh rate is maxed out
if hyprctl monitors | grep -q "eDP-1"; then
    hyprctl dispatch monitor eDP-1,120 2>/dev/null && echo "Refresh rate set to 120Hz"
fi

# Set CPU to performance mode
if [[ -d /sys/devices/system/cpu/cpu0/cpufreq/ ]]; then
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    echo "CPU set to performance mode"
fi

# Ensure AMD GPU runs at high performance
if command -v rocm-smi &>/dev/null; then
    rocm-smi --setperflevel high > /dev/null && echo "AMD GPU set to high performance"
    echo high | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
fi

# Mute notifications
if pgrep -x "dunst" > /dev/null; then
    dunstctl set-paused true && echo "Notifications muted"
fi

# Switch audio to headset if available
if pactl list sinks | grep -q "alsa_output.pci-0000_00_1f.3.analog-stereo"; then
    pactl set-default-sink "alsa_output.pci-0000_00_1f.3.analog-stereo" && echo "Audio switched to headset"
fi

# Enable Gamescope if running a game
export RADV_PERFTEST=gpl
export RADV_DEBUG=llvm

echo "Game Mode enabled! Launch your game now."
