local wezterm = require("wezterm") -- wezterm api

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
config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower"
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize() -- Maximize window
	window:gui_window():toggle_fullscreen() -- Toggle to Full screen
end)
config.font = wezterm.font("OpenDyslexicM Nerd Font Mono")
config.font_size = 10

-- Custom keybindings
config.keys = {
	{ -- ALT - Enter is used by workspacer
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
