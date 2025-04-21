#!/usr/bin/sh

dbus-launch --sh-syntax waybar &
swww-daemon
swww img $HOME/Pictures/wall/wallpaper.png

fcitx5 &

cpupower frequency-set -u 3000000
