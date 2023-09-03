#!/usr/bin/env bash

rofi_command="rofi -show drun -theme $HOME/.config/rofi/powermenu.rasi"

lock=" Lock"
log_out=" Logout"
power_off=" Power off"
reboot=" Reboot"

options="$lock\n$log_out\n$power_off\n$reboot"

chosen="$(echo -e "$options" | $rofi_command -dmenu)"
case $chosen in
  $lock)
    playerctl pause; i3lock-fancy-rapid 50 10 -n
    ;; 
  $log_out)
    #xfce4-session-logout --logout
    ;;   
  $power_off)
    systemctl poweroff
    ;;
  $reboot)
    systemctl reboot
    ;;
esac
