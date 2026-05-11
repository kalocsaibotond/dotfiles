# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  case ":$PATH:" in
  *":$HOME/bin:"*) ;;
  *) export PATH="$HOME/bin:$PATH" ;;
  esac
fi
if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
  esac
fi

export ENV="$HOME/.shrc"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

if command -v 'nvim' >'/dev/null' 2>&1; then
  if [ -r "$XDG_CONFIG_HOME/vim-pluginless/init.vim" ]; then
    export EDITOR='nvim -u "$XDG_CONFIG_HOME/vim-pluginless/init.vim"'
  else
    export EDITOR='nvim --clean'
  fi
elif command -v 'vim' >'/dev/null' 2>&1; then
  if [ -r "$XDG_CONFIG_HOME/vim-pluginless/init.vim" ]; then
    export EDITOR='vim -u "$XDG_CONFIG_HOME/vim-pluginless/init.vim"'
  else
    export EDITOR='vim --clean'
  fi
elif command -v 'vi' >'/dev/null' 2>&1; then
  export EDITOR='vi'
elif command -v 'ex' >'/dev/null' 2>&1; then
  export EDITOR='ex'
elif command -v 'ed' >'/dev/null' 2>&1; then
  export EDITOR='ed'
fi

if command -v 'nvim' >'/dev/null' 2>&1; then
  export VISUAL='nvim'
elif command -v 'vim' >'/dev/null' 2>&1; then
  export VISUAL='vim'
else
  export VISUAL="$EDITOR"
fi

if command -v 'moor' >'/dev/null' 2>&1; then
  export PAGER='moor'
  export MANPAGER='moor'
  export BAT_PAGER='moor -no-linenumbers -quit-if-one-screen'
elif command -v 'moar' >'/dev/null' 2>&1; then
  export PAGER='moar'
  export MANPAGER='moar'
  export BAT_PAGER='moar -no-linenumbers -quit-if-one-screen'
elif command -v 'less' >'/dev/null' 2>&1; then
  export PAGER='less -R'
  export MANPAGER='less'
else
  export PAGER='more'
  export MANPAGER='more'
fi

export BAT_CONFIG_DIR="$XDG_CONFIG_HOME/bat"

# Configuring nnn file manager
NNN_PLUG_OFFICIAL='z:autojump;f:finder;o:fzopen;p:preview-tabbed'
if [ -h "$XDG_CONFIG_HOME/nnn/plugins/official" ] ||
  [ -d "$XDG_CONFIG_HOME/nnn/plugins/official" ]; then
  export NNN_PLUG="$(echo "$NNN_PLUG_OFFICIAL" | sed 's/:/:official\//g')"
else
  export NNN_PLUG="$NNN_PLUG_OFFICIAL"
fi
unset NNN_PLUG_OFFICIAL

if [ -z "$NNN_OPENER" ]; then
  if [ -x "$XDG_CONFIG_HOME/nnn/plugins/official/nuke" ]; then
    NNN_OPENER="$XDG_CONFIG_HOME/nnn/plugins/official/nuke"
  elif [ -x "$XDG_CONFIG_HOME/nnn/plugins/nuke" ]; then
    export NNN_OPENER="$XDG_CONFIG_HOME/nnn/plugins/nuke"
  fi
fi
if [ -z "$NNN_FIFO" ]; then
  export NNN_FIFO='/tmp/nnn.fifo'
fi
if [ -z "$NNN_SEL" ]; then
  export NNN_SEL='/tmp/.sel'
fi
