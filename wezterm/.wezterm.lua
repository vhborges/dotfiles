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

-- This is where you actually apply your config choices.

-- Start in WSL
config.default_domain = "WSL:archlinux"

--- Set Pwsh as the default on Windows
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- Window
config.initial_cols = 120
config.initial_rows = 35
config.use_fancy_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Fonts
config.font_size = 12
config.window_frame = {
	font_size = 16.0,
}
--config.font = wezterm.font 'JetBrainsMono Nerd Font'

-- Appearance
config.color_scheme = "Catppuccin Macchiato"
--config.window_decorations = "RESIZE"
--config.hide_tab_bar_if_only_one_tab = true
--config.window_close_confirmation = "NeverPrompt"

-- Leader key
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 2000 }

-- Define variable
local action = wezterm.action

-- Keybindings
config.keys = {

	-- Split panes
	{
		key = "-",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "\\",
		mods = "LEADER",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- Navigate between panes
	{
		key = "h",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Right"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Up"),
	},

	-- Close pane
	{
		key = "d",
		mods = "LEADER",
		action = action.CloseCurrentPane({ confirm = false }),
	},

	-- Adjust pane size
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Left", 2 }),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Right", 2 }),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Down", 2 }),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Up", 2 }),
	},
	{
		key = "m",
		mods = "LEADER",
		action = action.TogglePaneZoomState,
	},

	-- Create new tab
	{
		key = "c",
		mods = "LEADER",
		action = action.SpawnTab("DefaultDomain"),
	},

	-- Create new tab (Windows Powershell)
	{
		key = "l",
		mods = "LEADER",
		action = action.SpawnTab({ DomainName = "local" }),
	},

	-- Close tab
	{
		key = "w",
		mods = "LEADER",
		action = action.CloseCurrentTab({ confirm = false }),
	},

	-- Cycle between tabs
	{
		key = "p",
		mods = "LEADER",
		action = action.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = action.ActivateTabRelative(1),
	},

	-- Vi mode
	{
		key = "[",
		mods = "LEADER",
		action = action.ActivateCopyMode,
	},
}

-- Go to specific tabs (1-9)
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

-- Finally, return the configuration to wezterm:
return config
