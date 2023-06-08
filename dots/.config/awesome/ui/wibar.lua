local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local helpers = require("helpers")

local cpu_widget = require("modules.awesome-wm-widgets.cpu-widget.cpu-widget")

--
-- Wibar
--

screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", }, s, awful.layout.layouts[1])

  -- Separator bar
  bar = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '|',
    align  = 'center',
    valign = 'center',
  }

  -- Separator space
  sep = wibox.widget {
    widget = wibox.widget.textbox,
    markup = ' ',
    align  = 'center',
    valign = 'center',
  }

  -- Percent
  perc = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '%',
    align  = 'center',
    valign = 'center',
  }

  -- Layoutbox
  layoutbox = awful.widget.layoutbox {
    screen  = s,
  }

  -- Clock
  clock = wibox.widget.textclock("%a %b %d, %I:%M %p")

  -- Taglist
  taglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    style = {
      shape = gears.shape.circle,
    },
    buttons = {
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end),
    },
  }

  -- Tasklist
  tasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    style = {
      shape = gears.shape.rounded_rect,
    },
    buttons = {
      awful.button({ }, 1, function (c)
        c:activate { context = "tasklist", action = "toggle_minimization", }
      end),
      awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
      awful.button({ }, 5, function() awful.client.focus.byidx(-1) end),
    },
  }

  -- Bar
  wibar = awful.wibar({
    position = "top",
    screen   = s,
    height   = 23,
    border_width = 2,
    border_color = beautiful.accent,
    type = "dock",
  })

  wibar:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- Left
      layout = wibox.layout.fixed.horizontal,
      taglist,
      bar,
      sep,
      wibox.widget.systray,
      sep,
    },
    { -- Center
      layout = wibox.layout.fixed.horizontal,
      tasklist,
    },
    { -- Right
      layout = wibox.layout.fixed.horizontal,
      sep,
      bar,
      sep,
      helpers.simplewtch([[sh -c "echo -n 'CPU ' && top -bn1 | grep '%Cpu' | awk '{print int(100-$8)}' && echo -n '%'"]], 1),
      sep,
      cpu_widget({
        width = 20,
        color = "#f35252",
      }),
      sep,
      bar,
      sep,
      helpers.simplewtch([[sh -c "echo -n 'GPU ' && nvidia-smi | grep 'Default' | cut -d '|' -f 4 | tr -d 'Default' | tr -d '[:space:]'"]], 1),
      sep,
      bar,
      sep,
      helpers.simplewtch([[sh -c "echo -n 'RAM ' && free -h | awk '/Mem:/{gsub(/Gi/,\"\",\$2); gsub(/Gi/,\"\",\$3); printf \"%.0f%%\", (\$3/\$2)*100}'"]], 2),
      sep,
      bar,
      sep,
      helpers.simplewtch([[sh -c "echo -n 'VOL ' && pamixer --get-volume"]], 0.25),
      perc,
      sep,
      bar,
      sep,
      clock,
      sep,
      bar,
      layoutbox,
    },
  }
end)
