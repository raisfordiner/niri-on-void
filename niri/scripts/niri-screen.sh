#!/usr/bin/env bash

fuzzelConfDir="$HOME/.config/fuzzel/niri-screen.ini"

actions=(
    "Screenshot"
    "Screenshot windows"
    "Screenshot screen"
    "Colorpicker"
)

chosen=$(printf '%s\n' "${actions[@]}" | fuzzel -d --config="$fuzzelConfDir")

sleep 0.1

case "$chosen" in
    0)
        niri msg action screenshot
        ;;
    1)
        niri msg action screenshot-window
        ;;
    2)
        niri msg action screenshot-screen
        ;;
    3)
        color=`niri msg pick-color | grep Hex | cut -d# -f2`
        zenity --color-selection --title="Copy color to Clipboard" --color=#$color
        ;;
esac
