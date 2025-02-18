export ENV="$HOME/.shrc"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="moar"
export MANPAGER="moar"

# Configuring bat pager
export BAT_PAGER="moar -no-linenumbers -quit-if-one-screen"
export BAT_CONFIG_DIR="$XDG_CONFIG_HOME/bat"

# Configuring nnn file manager
export NNN_PLUG='z:autojump;f:finder;o:fzopen;p:preview-tabbed'
export NNN_OPENER="$XDG_CONFIG_HOME/nnn/plugins/nuke"
export NNN_FIFO="/tmp/nnn.fifo"
