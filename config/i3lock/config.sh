#!/bin/bash

# Dapatkan jam sekarang (format 0–23)
hour=$(date +%H)
name="$USER"

if [ "$hour" -lt 6 ]; then
  greeting="おはよう、$name"
elif [ "$hour" -lt 15 ]; then
  greeting="こんにちは、$name"
elif [ "$hour" -lt 18 ]; then
  greeting="こんにちは、$name"
else
  greeting="こんばんは、$name"
fi

echo "$greeting"

i3lock \
  --blur 1 \
  --clock \
  --indicator \
  --time-str="%H:%M" \
  --date-str="%A, %d %B %Y" \
  --greeter-text="$greeting" \
  --greeter-color=ffffff \
  --time-color=88c0d0 \
  --date-color=81a1c1 \
  --layout-color=ebcb8b \
  --inside-color=2e3440 \
  --ring-color=5e81ac \
  --line-color=00000000 \
  --separator-color=00000000 \
  --keyhl-color=81a1c1 \
  --bshl-color=ffb86c \
  --wrong-color=88c0d0 \
  --verif-color=88c0d0 \
  --insidever-color=2e3340 \
  --insidewrong-color=2e3340 \
  --ringver-color=5e81ac \
  --ringwrong-color=5e81ac \
  --verif-text="Writing..." \
  --wrong-text="Wrong password" \
  --noinput-text="Empty Text" \
  --lock-text="Locking..." \
  --greeter-pos="x+950:y+250" \
  --greeter-align 0 \
  --greeter-size 24 \
  --radius=120 \
  --ring-width=8 \
  --pointer=default \
  --ignore-empty-password \
  --greeter-font="Noto Sans JP"
