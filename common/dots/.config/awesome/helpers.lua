local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local helpers = { }

function helpers.simpletxt(x, y, mt, mr, mb, ml, txt, fnt, ali)
  local simpletext = wibox.widget {
    id = "margin",
    widget = wibox.container.margin,
    margins = {
      top = mt,
      right = mr,
      bottom = mb,
      left = ml,
    },
    {
      id = "background",
      widget = wibox.container.background,
      forced_width = x,
      forced_height = y,
      fg = beautiful.fg_normal,
      bg = beautiful.bg_normal,
      {
        id = "textbox",
        widget = wibox.widget.textbox,
        text = txt,
        font = fnt,
        align = ali,
        valign = "center",
      },
    },
  }
  return simpletext
end

function helpers.simpleicn(x, y, mt, mr, mb, ml, txt, fnt)
  local simpleicon = wibox.widget {
    id = "margin",
    widget = wibox.container.margin,
    margins = {
      top = mt,
      right = mr,
      bottom = mb,
      left = ml,
    },
    {
      id = "background",
      widget = wibox.container.background,
      forced_width = x,
      forced_height = y,
      fg = beautiful.fg_normal,
      bg = beautiful.bg_normal,
      shape = gears.shape.rounded_rect,
      {
        widget = wibox.widget.textbox,
        markup = txt,
        font = fnt,
        align = "center",
        valign = "center",
      },
    },
  }
  return simpleicon
end

function helpers.simpleimg(x, y, mt, mr, mb, ml, img)
  local simpleimage = wibox.widget {
    id = "margin",
    widget = wibox.container.margin,
    margins = {
      top = mt,
      right = mr,
      bottom = mb,
      left = ml,
    },
    {
      id = "constraint",
      widget = wibox.container.constraint,
      forced_width = x,
      forced_height = y,
      shape = gears.shape.rounded_rect,
      {
        id = "imagebox",
        widget = wibox.widget.imagebox,
        resize = true,
        image = img,
      },
    },
  }
  return simpleimage
end

function helpers.simplebtn(x, y, mt, mr, mb, ml, txt, fnt)
  local simplebutton = wibox.widget {
    id = "margin",
    widget = wibox.container.margin,
    margins = {
      top = mt,
      right = mr,
      bottom = mb,
      left = ml,
    },
    {
      id = "background",
      widget = wibox.container.background,
      forced_width = x,
      forced_height = y,
      fg = beautiful.fg_normal,
      bg = beautiful.bg_normal,
      shape = gears.shape.rounded_rect,
      {
        id = "textbox",
        widget = wibox.widget.textbox,
        text = txt,
        font = fnt,
        align = "center",
        valign = "center",
      },
    },
  }
  simplebutton:get_children_by_id("background")[1]:connect_signal("mouse::enter", function()
    simplebutton:get_children_by_id("background")[1].fg = beautiful.fg_focus
    simplebutton:get_children_by_id("background")[1].bg = beautiful.bg_minimize
  end)
  simplebutton:get_children_by_id("background")[1]:connect_signal("mouse::leave", function()
    simplebutton:get_children_by_id("background")[1].fg = beautiful.fg_normal
    simplebutton:get_children_by_id("background")[1].bg = beautiful.bg_normal
  end)
  return simplebutton
end

function helpers.simplesldr(x, y, mt, mr, mb, ml, w, h, max)
  local simpleslider = wibox.widget {
    id = "margin",
    widget = wibox.container.margin,
    margins = {
      top = mt,
      right = mr,
      bottom = mb,
      left = ml,
    },
    {
      id = "background",
      widget = wibox.container.background,
      forced_width = x,
      forced_height = y,
      fg = beautiful.fg_normal,
      bg = beautiful.bg_normal,
      {
        id = "slider",
        widget = wibox.widget.slider,
        minimum = 0,
        maximum = max,
        handle_shape = gears.shape.circle,
        handle_color = beautiful.fg_normal,
        handle_width = 0,
        bar_height = h,
        bar_shape = gears.shape.rounded_rect,
        bar_color = beautiful.bg_minimize,
        bar_active_color = beautiful.fg_normal,
      },
    },
  }
  simpleslider:get_children_by_id("background")[1]:connect_signal("mouse::enter", function()
    simpleslider:get_children_by_id("slider")[1].handle_width = w
    simpleslider:get_children_by_id("slider")[1].bar_active_color = beautiful.fg_minimize
  end)
  simpleslider:get_children_by_id("background")[1]:connect_signal("mouse::leave", function()
    simpleslider:get_children_by_id("slider")[1].handle_width = 0
    simpleslider:get_children_by_id("slider")[1].bar_active_color = beautiful.fg_normal
  end)
  return simpleslider
end

function helpers.simplesldrhdn(x, y, mt, mr, mb, ml, w, h, max)
  local simplesliderhidden = wibox.widget {
    id = "margin",
    widget = wibox.container.margin,
    margins = {
      top = mt,
      right = mr,
      bottom = mb,
      left = ml,
    },
    {
      id = "background",
      widget = wibox.container.background,
      forced_width = x,
      forced_height = y,
      fg = beautiful.fg_normal,
      bg = "#00000000",
      {
        id = "slider",
        widget = wibox.widget.slider,
        minimum = 0,
        maximum = max,
        handle_shape = gears.shape.circle,
        handle_color = beautiful.fg_normal,
        handle_width = 0,
        bar_height = h,
        bar_shape = gears.shape.rounded_rect,
        bar_color = "#00000000",
        bar_active_color = "#00000000",
      },
    },
  }
  simplesliderhidden:get_children_by_id("background")[1]:connect_signal("mouse::enter", function()
    simplesliderhidden:get_children_by_id("slider")[1].handle_width = w
  end)
  simplesliderhidden:get_children_by_id("background")[1]:connect_signal("mouse::leave", function()
    simplesliderhidden:get_children_by_id("slider")[1].handle_width = 0
  end)
  return simplesliderhidden
end

function helpers.simpleprog(x, y, mt, mr, mb, ml, w, max)
  local simpleprogressbar = wibox.widget {
    id = "margin",
    widget = wibox.container.margin,
    margins = {
      top = mt,
      right = mr,
      bottom = mb,
      left = ml,
    },
    {
      id = "background",
      widget = wibox.container.background,
      forced_width = x,
      forced_height = y,
      fg = beautiful.fg_normal,
      bg = beautiful.bg_normal,
      {
        id = "progressbar",
        widget = wibox.widget.progressbar,
        color = beautiful.fg_normal,
        background_color = beautiful.bg_minimize,
        shape = gears.shape.rounded_rect,
        max_value = max,
        margins = { top = 6, bottom = 6,},
        forced_height = y,
        forced_width = w,
      },
    },
  }
  return simpleprogressbar
end

function helpers.simplernd(number, place)
  local decimal = (10 ^ place)
  local rounded = (math.floor((number * decimal) + (5 / decimal)) / decimal)
  return rounded
end

function helpers.simplewtch(com, time)
  local simplewatch = wibox.widget {
    widget = wibox.widget.textbox,
    align = "left",
    valign = "center",
  }
  awful.widget.watch(com, time, function(_, stdout)
    simplewatch.markup = stdout:gsub( "\n", "" )
  end)
  return simplewatch
end

function helpers.unfocus()
  client.focus = nil
  client.focus = awful.client.next(0)
  if client.focus then
    client.focus:raise()
  end
end

function helpers.locker()
  awful.spawn.with_shell("\
  playerctl pause; \
  i3lock-fancy-rapid 50 10 -n; \
  ")
end

return helpers
