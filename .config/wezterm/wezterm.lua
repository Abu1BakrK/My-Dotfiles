-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "Tokyo Night Moon"

config.font = wezterm.font ("Meslo LG M DZ for Powerline")
config.font_size = 12

config.initial_cols = 80
config.initial_rows = 24

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8

-- and finally, return the configuration to wezterm
return config
