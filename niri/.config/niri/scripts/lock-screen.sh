#!/usr/bin/env sh

SCREENSHOT="/tmp/swaylockshot.png"
BLURRED_SCREENSHOT="/tmp/swaylockshotblurred.png"

BLUR_ARG="20x10" 

COLOR_BACKGROUND="1F232888" 
COLOR_RING_DEFAULT="0969daff"
COLOR_RING_VERIFY="116329ff" 
COLOR_RING_WRONG="cf222eff"
COLOR_TEXT="ffffffff"    
COLOR_KEY_HL="4d2d00ff"   
COLOR_LINE_CLEAR="6e778100"

grim "${SCREENSHOT}"

# magick "${SCREENSHOT}" -scale 10% -blur ${BLUR_ARG} -scale 1000% "${BLURRED_SCREENSHOT}"
magick "${SCREENSHOT}" -scale 50% -blur ${BLUR_ARG} -scale 200% "${BLURRED_SCREENSHOT}"

swaylock \
    -i "${BLURRED_SCREENSHOT}" \
    \
    --indicator-radius 50 \
    --indicator-thickness 8 \
    \
    --inside-color "${COLOR_BACKGROUND}" \
    --inside-ver-color "${COLOR_BACKGROUND}" \
    --inside-wrong-color "${COLOR_BACKGROUND}" \
    --inside-clear-color "${COLOR_BACKGROUND}" \
    \
    --ring-color "${COLOR_RING_DEFAULT}" \
    --ring-ver-color "${COLOR_RING_VERIFY}" \
    --ring-wrong-color "${COLOR_RING_WRONG}" \
    --ring-clear-color "${COLOR_RING_DEFAULT}" \
    \
    --text-color "${COLOR_TEXT}" \
    --text-ver-color "${COLOR_TEXT}" \
    --text-wrong-color "${COLOR_TEXT}" \
    --text-clear-color "${COLOR_TEXT}" \
    \
    --line-color "${COLOR_LINE_CLEAR}" \
    --line-ver-color "${COLOR_LINE_CLEAR}" \
    --line-wrong-color "${COLOR_LINE_CLEAR}" \
    --line-clear-color "${COLOR_LINE_CLEAR}" \
    \
    --key-hl-color "${COLOR_KEY_HL}" \
    --bs-hl-color "${COLOR_RING_WRONG}"

rm "${SCREENSHOT}" "${BLURRED_SCREENSHOT}"
