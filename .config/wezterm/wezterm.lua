-- wezterm.lua
-- Ported from kitty.conf + current-theme.conf (Tokyo Night Night)
-- Goal: match kitty look/feel (font, cursor, splits, keymaps, colors)

local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- libssh-rs backend hangs on some hosts (e.g. over Tailscale DERP relay);
-- Ssh2 backend connects reliably
config.ssh_backend = "Ssh2"

-- Start maximized (full size) on launch
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.font_size = 16.0

-- Nerd Font icon glyphs are square (2 cells wide) but Menlo's cell is narrow;
-- without this they get squeezed into 1 cell and render distorted/janky
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

-- Wezterm's linear-alpha AA renders macOS system fonts thinner than CoreText's
-- gamma-corrected AA (Terminal/kitty/iTerm). Normal hinting + bumping to
-- Medium weight above compensates for the visual weight loss.
config.freetype_load_target = "Normal"
config.freetype_render_target = "Normal"

-- Tab bar (hidden when only one tab open, flat retro style to match theme colors)
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = true

-- Cursor (kitty: cursor_shape block, default blink)
config.default_cursor_style = "BlinkingBlock"

-- kitty: dim_opacity 1 -> no dimming of inactive panes
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

-- Tokyo Night Night colors (from kitty current-theme.conf)
config.colors = {
	foreground = "#c0caf5",
	background = "#1a1b26",
	selection_fg = "none",
	selection_bg = "#364a80",

	cursor_fg = "#1a1b26",
	cursor_bg = "#c0caf5",
	cursor_border = "#c0caf5",

	tab_bar = {
		background = "#16161e",
		active_tab = {
			bg_color = "#1f2335",
			fg_color = "#c0caf5",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#16161e",
			fg_color = "#565f89",
		},
		inactive_tab_hover = {
			bg_color = "#1f2335",
			fg_color = "#c0caf5",
		},
		new_tab = {
			bg_color = "#16161e",
			fg_color = "#565f89",
		},
		new_tab_hover = {
			bg_color = "#1f2335",
			fg_color = "#7aa2f7",
		},
	},

	split = "#7aa2f7",

	ansi = {
		"#1a1b26", -- black
		"#f7768e", -- red
		"#9ece6a", -- green
		"#e0af68", -- yellow
		"#7aa2f7", -- blue
		"#bb9af7", -- magenta
		"#7dcfff", -- cyan
		"#c0caf5", -- white
	},
	brights = {
		"#414868", -- bright black
		"#f7768e", -- bright red
		"#9ece6a", -- bright green
		"#e0af68", -- bright yellow
		"#7aa2f7", -- bright blue
		"#bb9af7", -- bright magenta
		"#7dcfff", -- bright cyan
		"#c0caf5", -- bright white
	},
}

-- kitty pane border colors -> wezterm active/inactive pane border
config.colors.tab_bar.active_tab.bg_color = "#1f2335"
config.window_frame = {
	font = wezterm.font({ family = "Menlo", weight = "Medium" }),
	active_titlebar_bg = "#16161e",
	inactive_titlebar_bg = "#16161e",
}
-- active_border_color / inactive_border_color equivalent
config.colors.split = "#7aa2f7"

-- Splits / layout (kitty: enabled_layouts splits)
-- wezterm has no separate layout concept, panes work natively

-- Keymaps (matching kitty.conf mappings)
config.keys = {
	-- ctrl+shift+plus -> hsplit (kitty: divides window top/bottom)
	{
		key = "+",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
			top_level = false,
		}),
	},
	-- ctrl+shift+3 -> vsplit (kitty: divides window left/right)
	{
		key = "3",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
			top_level = false,
		}),
	},
	-- ctrl+shift+l -> next_window
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Next"),
	},
	-- ctrl+shift+h -> previous_window
	{
		key = "H",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Prev"),
	},
	-- ctrl+f -> search (kitty used search.py kitten)
	{
		key = "f",
		mods = "CTRL",
		action = act.Search({ CaseInSensitiveString = "" }),
	},
	-- cmd+= / cmd+- -> zoom font in/out, cmd+0 -> reset
	{ key = "=", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "=", mods = "CMD|SHIFT", action = act.IncreaseFontSize },
	{ key = "+", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "+", mods = "CMD|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "-", mods = "CMD|SHIFT", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },
	{ key = "0", mods = "CMD|SHIFT", action = act.ResetFontSize },

	-- Tabs
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "]", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "[", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "1", mods = "CMD", action = act.ActivateTab(0) },
	{ key = "2", mods = "CMD", action = act.ActivateTab(1) },
	{ key = "3", mods = "CMD", action = act.ActivateTab(2) },
	{ key = "4", mods = "CMD", action = act.ActivateTab(3) },
	{ key = "5", mods = "CMD", action = act.ActivateTab(4) },
	{ key = "6", mods = "CMD", action = act.ActivateTab(5) },
	{ key = "7", mods = "CMD", action = act.ActivateTab(6) },
	{ key = "8", mods = "CMD", action = act.ActivateTab(7) },
	{ key = "9", mods = "CMD", action = act.ActivateTab(-1) },
}

return config
