#!/bin/bash

HLLOG="$HOME/hyprlock-fix.log"
set -e
trap 'echo "Failed to fix hyprlock" | tee -a "$HLLOG"' ERR

echo "Fixing Hyprlock"
hyprctl --instance 0 keyword misc:allow_session_lock_restore 1

hyprctl --instance 0 dispatch exec hyprlock

echo "Hyprlock fixed"
