local awful = require("awful")
local b = require("beautiful")

b.init(os.getenv("HOME") .. "/.config/awesome/config/theme.lua")

local autostart = os.getenv("HOME") .. "/.config/autostart/"
awful.spawn.easy_async_with_shell("test -f " .. autostart .. "awesome.sh && echo true || echo false", function(file_test)
  file_test = file_test:gsub("\n", "")
  if file_test == "true" then
    awful.spawn.easy_async_with_shell("sh " .. autostart .. "awesome.sh")
  end
end)

terminal = "tym"
browser = "firefox"
editor = os.getenv("EDITOR") or "nano"
visual_editor = "code"
editor_cmd = terminal .. " -e " .. editor

require("config")
require("ui")
require("signal")
