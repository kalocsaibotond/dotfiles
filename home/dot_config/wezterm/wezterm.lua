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

-- Things to do on gui startup
wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize() -- Maximize window
	window:gui_window():toggle_fullscreen() -- Toggle to Full screen
end)

config.font = wezterm.font("OpenDyslexicM Nerd Font Mono")

return config
