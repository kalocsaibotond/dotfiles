# XDG Base directories
$ENV:XDG_DATA_HOME = "$HOME\.local\share"
$ENV:XDG_CONFIG_HOME = "$HOME\.config"
$ENV:XDG_STATE_HOME = "$HOME\.local\state"
$ENV:XDG_CACHE_HOME = "$HOME\.cache"

# Accessories
$ENV:EDITOR = "nvim"
$ENV:VISUAL = $EDITOR
$ENV:PAGER = "moar"
$ENV:MANPAGER = "moar"

# Configuration
$ENV:BAT_PAGER = "moar -no-linenumbers -quit-if-one-screen"
