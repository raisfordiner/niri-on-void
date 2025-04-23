#!/usr/bin/sh

pidof swaylock || swaylock \
    -c 000000\
    --indicator-idle-visible\
    --inside-color 000000
