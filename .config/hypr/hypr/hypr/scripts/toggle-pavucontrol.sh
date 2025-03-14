#!/bin/bash

if pgrep -x "pavucontrol" > /dev/null
then
    pkill pavucontrol
else
    hyprctl dispatch exec '[float] pavucontrol'
fi

