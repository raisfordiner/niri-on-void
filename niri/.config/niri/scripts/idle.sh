#!/usr/bin/env sh

swayidle -w \
    timeout 300 '~/.config/niri/scripts/lock-screen.sh' \
    \
    before-sleep '~/.config/niri/scripts/lock-screen.sh'
