#!/bin/bash

# Set output file path (temporary)
IMAGE=/tmp/blurred_lock.png

# Get current display and resolution (X11)
DISPLAY_ID=${DISPLAY:-:0.0}
RES=$(xrandr | grep '*' | awk '{print $1}')

ffmpeg -video_size $RES -f x11grab -i $DISPLAY_ID -vframes 1 -vf "boxblur=10:1" "$IMAGE"

# Lock screen with i3lock using blurred image
i3lock -i "$IMAGE"

# Optionally delete the image after unlocking (optional)
rm "$IMAGE"
