#!/usr/bin/env bash

fuzzelConfDir="$HOME/.config/fuzzel/power-options.ini"

#There is no sleep/suspend cause it sucks
actions=(
    " "
    " 󰐥"
    " "
    " 󰍃"
)

chosen=$(printf '%s\n' "${actions[@]}" | fuzzel -d --config="$fuzzelConfDir")

case "$chosen" in
    0)
        ~/.config/niri/scripts/lockscreen.sh
        ;;
    1)
        loginctl poweroff
        ;;
    2)
        loginctl reboot
        ;;
    3)
        loginctl kill-session $XDG_SESSION_ID
        ;;
esac
