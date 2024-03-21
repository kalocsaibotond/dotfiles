local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = {
	[[
    pwsh -ExecutionPolicy Bypass
  ]],
}

return config
