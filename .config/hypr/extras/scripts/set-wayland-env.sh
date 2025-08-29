#!/bin/bash
export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=$(ls "$XDG_RUNTIME_DIR" | grep -m1 '^wayland-')

# Start swww-daemon with the right vars
swww-daemon &
