-- https://wezfurlong.org/wezterm/config/files.html
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "rose-pine"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 16
config.scrollback_lines = 10000

-- and finally, return the configuration to wezterm
return config
