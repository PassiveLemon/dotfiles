local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init("/home/lemon/.config/awesome/config/theme.lua")

require("config.keybindings")
require("config.notifications")
require("config.rules")
require("config.wibar")

awful.spawn.easy_async("xrandr --output DP-0 --primary --mode 1920x1080 --rate 143.9 --rotate normal --output DP-2 --mode 1920x1080 --rate 143.9 --rotate normal --left-of DP-0")

awful.spawn.easy_async([[sh -c "kill $(pgrep easyeffects) ; sleep 0.2 && easyeffects --gapplication-service"]])
awful.spawn.easy_async("picom -b")
awful.spawn.easy_async("nm-applet")
awful.spawn.easy_async("megasync")

awful.spawn.easy_async([[sh -c "xwinwrap -ov -g 1920x1080+0+0 -- mpv -wid WID /home/HDD2TBEXT4/Downloads/fallen-leaves-lake-moewalls.com.mp4 --no-osc --no-osd-bar --loop-file --player-operation-mode=cplayer --no-audio --panscan=1.0 --no-input-default-bindings"]])
awful.spawn.easy_async([[sh -c "xwinwrap -ov -g 1920x1080+1920+0 -- mpv -wid WID /home/HDD2TBEXT4/Downloads/fallen-leaves-lake-moewalls.com.mp4 --no-osc --no-osd-bar --loop-file --player-operation-mode=cplayer --no-audio --panscan=1.0 --no-input-default-bindings"]])

