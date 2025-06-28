#!/bin/bash

# 1. Check if Caps Lock is ON using xset
CAPS_STATE=$(xset q | grep "Caps Lock:" | awk '{print $4}')

# 2. Turn off Caps Lock if it is ON
if [ "$CAPS_STATE" == "on" ]; then
    xdotool key Caps_Lock
fi

# 3. Remap Caps Lock to Left Ctrl
# 4. Remap Left Alt to Caps Lock
setxkbmap -option ctrl:nocaps
setxkbmap -option caps:swapalt
