local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- TODO: Check os and shell availability and define logic for preference
config.default_prog = {
	[[pwsh]],
}

return config
