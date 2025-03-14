#!/bin/bash

echo "Disabling Game Mode..."

hyprctl keyword decoration:blur:enabled true 2>/dev/null && echo "Blur enabled"
hyprctl keyword decoration:shadow:enabled true 2>/dev/null && echo "Shadows enabled"
hyprctl keyword animations:enabled true 2>/dev/null && echo "Animations enabled"
hyprctl keyword general:layout dwindle 2>/dev/null && echo "Layout restored"

if [[ -d /sys/devices/system/cpu/cpu0/cpufreq/ ]]; then
    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor && echo "CPU set to powersave mode"
fi

command -v nvidia-settings &>/dev/null && nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=2' && echo "NVIDIA GPU restored"
command -v rocm-smi &>/dev/null && rocm-smi --setperflevel auto && echo "AMD GPU restored"

if pgrep -x "dunst" > /dev/null; then
    dunstctl set-paused false && echo "Notifications unmuted"
fi

if pactl list sinks | grep -q "alsa_output.pci-0000_00_1f.3.analog-stereo"; then
    pactl set-default-sink "alsa_output.pci-0000_00_1f.3.analog-stereo" && echo "Audio restored"
fi

echo "Game Mode disabled!"

