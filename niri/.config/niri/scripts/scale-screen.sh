#!/usr/bin/env sh

numOutputs="$(niri msg outputs | grep Output | wc -l)"
if [ "$numOutputs" -eq 1 ]; then
    niri msg output eDP-1 scale 1.25;
else
    niri msg output eDP-1 scale 1.6;
fi
