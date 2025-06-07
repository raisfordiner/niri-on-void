#!/usr/bin/bash

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
        rgb_color=`zenity --color-selection --title="Copy color to Clipboard" --color=#$color`

        if [ "$rgb_color" != "" ]; then
            hex_color="#"
            for value in $(echo "${rgb_color}" | grep -E -o -m1 '[0-9]+'); do
                hex_color="$hex_color$(printf "%.2x" $value)"
            done
        echo $hex_color | wl-copy -n
        fi
        ;;
esac
