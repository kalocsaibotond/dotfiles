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
NNN_PLUG_OFFICIAL='z:autojump;f:finder;o:fzopen;p:preview-tabbed'
if [ -h "$XDG_CONFIG_HOME/nnn/plugins/official" ] ||
  [ -d "$XDG_CONFIG_HOME/nnn/plugins/official" ]; then
  NNN_PLUG=$(echo $NNN_PLUG_OFFICIAL | sed 's/:/:official\//g')
else
  NNN_PLUG=$NNN_PLUG_OFFICIAL
fi
unset NNN_PLUG_OFFICIAL
export NNN_PLUG

if [ -z "$NNN_OPENER" ]; then
  export NNN_OPENER="$XDG_CONFIG_HOME/nnn/plugins/nuke"
fi
if [ -z "$NNN_FIFO" ]; then
  export NNN_FIFO="/tmp/nnn.fifo"
fi
if [ -z "$NNN_SEL" ]; then
  export NNN_SEL=/tmp/.sel
fi
