-- Hyprland configuration overrides
-- Add your custom settings here

-- env = WLR_NO_HARDWARE_CURSORS,1

-- Example overrides:
-- $mainMod = SUPER
-- $terminal = uwsm app -- kitty
-- hl.env("browser", "omarchy-launch-browser --force-device-scale-factor=1")

-- Use single default monitor (see all monitors with: hyprctl monitors)
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Keep this laptop at its personal 1x scale after Omarchy's monitor defaults.
hl.env("GDK_SCALE", "1")
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- trigger when the switch is turning on
-- hl.bind("switch:on:Lid Switch", function() hl.dispatch(hl.dsp.monitor_set({ output = "eDP-1", disabled = true })) end)
-- trigger when the switch is turning off
-- hl.bind("switch:off:Lid Switch", function() hl.dispatch(hl.dsp.monitor_set({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })) end)

-- bind = SUPER SHIFT, D, exec, hyprctl keyword monitor eDP-1, disable
-- bind = SUPER SHIFT, F, exec, hyprctl keyword monitor eDP-1, preferred, auto, 1.6

-- Override Discord binding
hl.unbind("SUPER + D")
o.bind("SUPER + D", "Discord", "omarchy-launch-or-focus-webapp Discord https://discord.com/channels/@me")

-- Override Notion binding
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "Notion", "omarchy-launch-or-focus-webapp Notion https://www.notion.so/")

hl.unbind("SUPER + M")
o.bind("SUPER + M", "Apple Music", "omarchy-launch-or-focus-webapp AppleMusic https://music.apple.com/")

-- Override terminal binding
-- hl.unbind("SUPER + RETURN")
-- o.bind("SUPER + RETURN", "Terminal", "$terminal")

-- Override browser binding
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Browser", "$browser")
hl.unbind("SUPER + SHIFT + ALT + B")
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", "$browser --private")

-- bind = SUPER, C, killactive,
-- hyprctl dispatch dpms on bind = SUPER, M, exit,
o.bind("SUPER + E", nil, "uwsm-app -- nautilus --new-window")
o.bind("SUPER + SHIFT + R", nil, "hyprctl reload")
hl.unbind("SUPER + L")
o.bind("SUPER + L", nil, "hyprlock")

-- hl.unbind("SUPER + H")
-- hl.unbind("SUPER + J")
-- hl.unbind("SUPER + SHIFT + J")
-- hl.unbind("SUPER + K")
-- hl.unbind("SUPER + SHIFT + K")
-- hl.unbind("SUPER + L")

-- Move focus with mainMod + arrow keys
-- o.bind("SUPER + H", nil, "movefocus l")
-- o.bind("SUPER + L", nil, "movefocus r")
-- o.bind("SUPER + K", nil, "movefocus u")
-- o.bind("SUPER + J", nil, "movefocus d")

hl.config({
  misc = {
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
  },
})

hl.config({
  input = {
    -- Use multiple keyboard layouts and switch between them with Alt + Space
    -- kb_layout = "us,dk",
    -- kb_options = "compose:caps,grp:alt_space_toggle",
    kb_options = "ctrl:nocaps",

    -- Change speed of keyboard repeat
    -- repeat_rate = 50,
    -- repeat_delay = 220,
    repeat_rate = 40,
    repeat_delay = 300,

    -- Increase sensitity for mouse/trackpack (default: 0)
    -- sensitivity = 0.35,

    touchpad = {
      -- Use natural (inverse) scrolling
      natural_scroll = true,

      -- Use two-finger clicks for right-click instead of lower-right corner
      -- clickfinger_behavior = true,

      -- Control the speed of your scrolling
      scroll_factor = 0.4,
    },
  },
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.8,
})

-- External gaming mouse
hl.device({
  name = "e-signal-usb-gaming-mouse",
  sensitivity = -0.8,
})
