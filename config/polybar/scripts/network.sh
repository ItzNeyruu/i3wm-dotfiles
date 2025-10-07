#!/bin/bash

# interface
active_iface=$(ip route | grep '^default' | awk '{print $5}')

# Ethernet
if [[ "$active_iface" == e* || "$active_iface" == en* ]]; then
  icon="󰈀"
  color="%{F#F0C674}"  # Biru terang
  echo "%{A1:kitty --detach nmtui:}${color}${icon}%{F-} Ethernet%{A}"

# wifi
elif [[ "$active_iface" == wl* ]]; then
  info=$(nmcli -t -f IN-USE,SSID,SIGNAL dev wifi | grep '^\*')
  ssid=$(echo "$info" | cut -d: -f2)
  signal=$(echo "$info" | cut -d: -f3)

  # icon and color
  if [ "$signal" -ge 80 ]; then
    icon="󰤨"
    color="%{F#F0C674}"
  elif [ "$signal" -ge 60 ]; then
    icon="󰤥"
    color="%{F#F0C674}"
  elif [ "$signal" -ge 40 ]; then
    icon="󰤢"
    color="%{F#F0C674}"
  elif [ "$signal" -ge 20 ]; then
    icon="󰤟"
    color="%{F#F0C674}"
  else
    icon="󰤯"
    color="%{F#F0C674}"
  fi

  echo "${color}${icon}%{F-} $signal% ($ssid)%{A}"

# no connection
else
  icon="󰲜"
  color="%{F#ff5555}"  # red
  echo "%{A1:kitty --detach nmtui:}${color}${icon}%{F-} Offline%{A}"
fi
