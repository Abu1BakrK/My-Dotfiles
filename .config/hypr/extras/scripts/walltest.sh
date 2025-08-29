#!/bin/bash
export WAYLAND_DISPLAY=$(ls $XDG_RUNTIME_DIR | grep -m1 '^wayland-')
swww-daemon &
swww img /home/abubakr/wall/wallpaper.jpg
