#!/usr/bin/sh

# pkill waybar || dbus-launch --sh-syntax waybar &
pgrep -x waybar > /dev/null && pkill -x waybar || waybar &

