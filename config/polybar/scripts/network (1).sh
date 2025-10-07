#!/bin/bash

if ip link show enp1s0 | grep -q "state UP"; then
  echo "%{A1:kitty --detach nmtui:} Wired%{A}"
elif ip link show wlp2s0 | grep -q "state UP"; then
  echo "%{A1:kitty --detach nmtui:} $signal% ($essid)%{A}"
else
  echo "%{A1:kitty --detach nmtui:} Disconnect%{A}"
fi
