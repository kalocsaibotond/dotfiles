local wezterm = require("wezterm") -- wezterm api

-- Maximise and full screen on startup
wezterm.on("gui-startup", function(cmd)
	-- https://wezfurlong.org/wezterm/config/lua/gui-events/gui-startup.html
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize() -- Maximize window
	window:gui_window():toggle_fullscreen() -- Toggle to Full screen
end)

-- Initialising configuration table
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Setting shell config logic
if wezterm.target_triple:find("windows") then
	local success, stdout, _ = wezterm.run_child_process({
		"powershell",
		"-Command",
		"[bool](Get-Command -Name pwsh -ErrorAction SilentlyContinue)",
	})
	if success then
		if stdout:find("True") then
			config.default_prog = {
				"pwsh",
				"-NoExit",
				"-ExecutionPolicy",
				"Bypass",
			}
		else
			config.default_prog = {
				"powershell",
				"-NoExit",
				"-ExecutionPolicy",
				"Bypass",
			}
		end
	end
end

-- Rendering settings
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("OpenDyslexicM Nerd Font Mono")
config.font_size = 10

-- Custom keybindings
config.keys = {
	{ -- Eliminating window close confirmation
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "Enter",
		mods = "CTRL",
		action = wezterm.action({ SendString = "\x1b[13;5u" }),
	},
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action({ SendString = "\x1b[13;2u" }),
	},
}

return config
