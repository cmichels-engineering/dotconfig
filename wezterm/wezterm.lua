-- Pull in the wezterm API
local wezterm = require 'wezterm'
local keybinds = require 'config.keybinds'
local pr_monitor = require 'pr-monitor'
-- This will hold the configuration.
local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

-- config.color_scheme = 'Gogh (Gogh)'
-- config.color_scheme = 'Dark+'
config.color_scheme = 'Darktooth (base16)'
config.font = wezterm.font("MesloLGS Nerd Font Mono")


-- tabs
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
  enabled_modules = {
    username = false,
    hostname = false
  }
})


config.inactive_pane_hsb = {
  saturation = 0.1,
  brightness = 0.2,
}

config.disable_default_key_bindings = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.keys = keybinds


-- window
config.window_decorations = "RESIZE"
config.window_frame = {
  border_left_width = '0.2cell',
  border_right_width = '0.2cell',
  border_top_height = '0.07cell',
  border_bottom_height = '0.07cell',
  border_left_color = 'blue',
  border_right_color = 'blue',
  border_top_color = 'orange',
  border_bottom_color = 'orange',
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 2,
  bottom = 2,
}
config.window_background_opacity = 0.92

-- pr-monitor: auto-launch tab + status badge alongside bar.wezterm
pr_monitor.setup_with_bar(config)

-- Return the configuration to wezterm
return config
