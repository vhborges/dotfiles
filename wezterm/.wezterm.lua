-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- Start in fullscreen
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Start in WSL
config.default_domain = "WSL:archlinux"

--- Set Pwsh as the default on Windows
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- Window
--config.initial_cols = 120
--config.initial_rows = 35
config.use_fancy_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Fonts
config.font_size = 12
--config.window_frame = {
--	font_size = 16.0,
--}
--config.font = wezterm.font 'JetBrainsMono Nerd Font'

-- Appearance
config.color_scheme = "Catppuccin Macchiato"
--config.window_decorations = "RESIZE"
--config.hide_tab_bar_if_only_one_tab = true
--config.window_close_confirmation = "NeverPrompt"

-- Vim modal plugin
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
modal.apply_to_config(config)
modal.set_default_keys(config)

-- Finally, return the configuration to wezterm:
return config
