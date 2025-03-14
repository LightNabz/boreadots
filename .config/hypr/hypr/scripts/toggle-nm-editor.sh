#!/bin/bash

if pgrep -f "nm-connection-editor" > /dev/null
then
    pkill -f "nm-connection-editor"
else
    hyprctl dispatch exec '[float] nm-connection-editor'
fi

