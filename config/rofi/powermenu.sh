#!/bin/bash

options=" Lock\n🗘 Restart\n⏻ Shutdown\n Suspend\n⍈ Logout"
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/powertheme.rasi)

case "$chosen" in
  " Lock") ~/.config/i3lock/config.sh ;;

  "🗘 Restart")
    confirm=$(echo -e " Yes\n No" | rofi -dmenu -i -p "Restart system?" -theme ~/.config/rofi/confirm.rasi)
    [[ "$confirm" == " Yes" ]] && systemctl reboot
    [[ "$confirm" == " No" ]] && ~/.config/rofi/powermenu.sh
    ;;

  "⏻ Shutdown")
    confirm=$(echo -e " Yes\n No" | rofi -dmenu -i -p "Shutdown system?" -theme ~/.config/rofi/confirm.rasi)
    [[ "$confirm" == " Yes" ]] && systemctl poweroff
    [[ "$confirm" == " No" ]] && ~/.config/rofi/powermenu.sh
    ;;

  " Suspend") systemctl suspend ;;

  "⍈ Logout")
    confirm=$(echo -e " Yes\n No" | rofi -dmenu -i -p "Logout?" -theme ~/.config/rofi/confirm.rasi)
    [[ "$confirm" == " Yes" ]] && loginctl terminate-session "$XDG_SESSION_ID"
    [[ "$confirm" == " No" ]] && ~/.config/rofi/powermenu.sh
    ;;

  *) exit 1 ;;
esac
