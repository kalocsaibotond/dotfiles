# Vi prompt editng
set -o vi

# Set shell prompt
case $SHELL_NAME in
'bash')
  PS1=$(echo $PS1 | sed "s/\\\\s-\\\\v\\\\\\$\$/\\[\\\\u@\\\\h \\\\W\\$\\] /")
  ;;
esac

# Zoxide initialisation
if ! command -v z >/dev/null && command -v zoxide >/dev/null; then
  case $SHELL_NAME in
  'bash') eval "$(zoxide init bash --hook prompt)" ;;
  'ksh') eval "$(zoxide init ksh --hook prompt)" ;;
  'mksh') eval "$(zoxide init ksh --hook prompt)" ;;
  'oksh') eval "$(zoxide init ksh --hook prompt)" ;;
  'zsh') eval "$(zoxide init zsh --hook prompt)" ;;
  *) eval "$(zoxide init posix --hook prompt)" ;;
  esac
fi

initialise_conda() {
  if [ -d "$2/miniforge3" ] &&
    [ -x "$2/miniforge3/bin/conda" ]; then
    anaconda_path="$2/miniforge3"
  elif [ -d "$HOME/.opt/miniforge3" ] &&
    [ -x "$HOME/.opt/miniforge3/bin/conda" ]; then
    anaconda_path="$HOME/.opt/miniforge3"
  elif [ -d "$HOME/.local/miniforge3" ] &&
    [ -x "$HOME/.local/miniforge3/bin/conda" ]; then
    anaconda_path="$HOME/.local/miniforge3"
  elif [ -d "$HOME/miniforge3" ] &&
    [ -x "$HOME/miniforge3/bin/conda" ]; then
    anaconda_path="$HOME/miniforge3"
  elif [ -d '/opt/miniforge3' ] &&
    [ -x '/opt/miniforge3/bin/conda' ]; then
    anaconda_path='/opt/miniforge3'
  elif [ -d '/usr/local/miniforge3' ] &&
    [ -x '/usr/local/miniforge3/bin/conda' ]; then
    anaconda_path='/usr/local/miniforge3'
  elif [ -d "$2/anaconda3" ] &&
    [ -x "$2/anaconda3/bin/conda" ]; then
    anaconda_path="$2/anaconda3"
  elif [ -d "$HOME/.opt/anaconda3" ] &&
    [ -x "$HOME/.opt/anaconda3/bin/conda" ]; then
    anaconda_path="$HOME/.opt/anaconda3"
  elif [ -d "$HOME/.local/anaconda3" ] &&
    [ -x "$HOME/.local/anaconda3/bin/conda" ]; then
    anaconda_path="$HOME/.local/anaconda3"
  elif [ -d "$HOME/anaconda3" ] &&
    [ -x "$HOME/anaconda3/bin/conda" ]; then
    anaconda_path="$HOME/anaconda3"
  elif [ -d '/opt/anaconda3' ] &&
    [ -x '/opt/anaconda3/bin/conda' ]; then
    anaconda_path='/opt/anaconda3'
  elif [ -d '/usr/local/anaconda3' ] &&
    [ -x '/usr/local/anaconda3/bin/conda' ]; then
    anaconda_path='/usr/local/anaconda3'
  elif [ -d "$2/miniconda3" ] &&
    [ -x "$2/miniconda3/bin/conda" ]; then
    anaconda_path="$2/miniconda3"
  elif [ -d "$HOME/.opt/miniconda3" ] &&
    [ -x "$HOME/.opt/miniconda3/bin/conda" ]; then
    anaconda_path="$HOME/.opt/miniconda3"
  elif [ -d "$HOME/.local/miniconda3" ] &&
    [ -x "$HOME/.local/miniconda3/bin/conda" ]; then
    anaconda_path="$HOME/.local/miniconda3"
  elif [ -d "$HOME/miniconda3" ] &&
    [ -x "$HOME/miniconda3/bin/conda" ]; then
    anaconda_path="$HOME/miniconda3"
  elif [ -d '/opt/miniconda3' ] &&
    [ -x '/opt/miniconda3/bin/conda' ]; then
    anaconda_path='/opt/miniconda3'
  elif [ -d '/usr/local/miniconda3' ] &&
    [ -x '/usr/local/miniconda3/bin/conda' ]; then
    anaconda_path='/usr/local/miniconda3'
  else
    echo "Could not find an anaconda installation"
    return 1
  fi
  echo "Found anaconda3 installation: $anaconda_path"

  # NOTE: This is the generalisation of what comes from conda init.
  case $SHELL_NAME in
  "bash") __conda_setup="$(
    "$anaconda_path/bin/conda" 'shell.bash' 'hook' 2>/dev/null
  )" ;;
  "zsh") __conda_setup="$(
    "$anaconda_path/bin/conda" 'shell.bash' 'hook' 2>/dev/null
  )" ;;
  *)
    echo "Conda do not supports the running shell: $SHELL_NAME"
    return 1
    ;;
  esac

  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$anaconda_path/etc/profile.d/conda.sh" ]; then
      . "$anaconda_path/etc/profile.d/conda.sh"
    else
      case ":$PATH:" in
      *":$anaconda_path/bin:"*) ;;
      *) PATH="$anaconda_path/bin:$PATH" ;;
      esac
      export PATH="$anaconda_path/bin:$PATH"
    fi
  fi
  unset __conda_setup
  unset anaconda_path

  if [ -n "$1" ]; then
    conda activate "$1"
  fi
}

initialise_mamba() {
  if [ -d "$2/miniforge3" ] &&
    [ -x "$2/miniforge3/bin/conda" ]; then
    MAMBA_ROOT_PREFIX="$2/miniforge3"
  elif [ -d "$HOME/.opt/miniforge3" ] &&
    [ -x "$HOME/.opt/miniforge3/bin/conda" ]; then
    MAMBA_ROOT_PREFIX="$HOME/.opt/miniforge3"
  elif [ -d "$HOME/.local/miniforge3" ] &&
    [ -x "$HOME/.local/miniforge3/bin/conda" ]; then
    MAMBA_ROOT_PREFIX="$HOME/.local/miniforge3"
  elif [ -d "$HOME/miniforge3" ] &&
    [ -x "$HOME/miniforge3/bin/conda" ]; then
    MAMBA_ROOT_PREFIX="$HOME/miniforge3"
  elif [ -d '/opt/miniforge3' ] &&
    [ -x '/opt/miniforge3/bin/conda' ]; then
    MAMBA_ROOT_PREFIX='/opt/miniforge3'
  elif [ -d '/usr/local/miniforge3' ] &&
    [ -x '/usr/local/miniforge3/bin/conda' ]; then
    MAMBA_ROOT_PREFIX='/usr/local/miniforge3'
  else
    echo "Could not find an mamba installation"
    return 1
  fi
  echo "Found miniforge3 installation: $MAMBA_ROOT_PREFIX"
  export MAMBA_ROOT_PREFIX

  # NOTE: This is the generalisation of what comes from mamba shell init
  export MAMBA_EXE="$MAMBA_ROOT_PREFIX/bin/mamba"
  case $SHELL_NAME in
  "bash") __mamba_setup="$(
    "$MAMBA_EXE" shell hook --shell 'bash' --root-prefix \
      "$MAMBA_ROOT_PREFIX" 2>/dev/null
  )" ;;
  "dash") __mamba_setup="$(
    "$MAMBA_EXE" shell hook --shell 'dash' --root-prefix \
      "$MAMBA_ROOT_PREFIX" 2>/dev/null
  )" ;;
  "zsh") __mamba_setup="$(
    "$MAMBA_EXE" shell hook --shell 'zsh' --root-prefix \
      "$MAMBA_ROOT_PREFIX" 2>/dev/null
  )" ;;
  *) __mamba_setup="$(
    "$MAMBA_EXE" shell hook --shell 'posix' --root-prefix \
      "$MAMBA_ROOT_PREFIX" 2>/dev/null
  )" ;;
  esac

  if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
  else
    alias mamba="$MAMBA_EXE" # Fallback on help from mamba activate
  fi
  unset __mamba_setup

  if [ -n "$1" ]; then
    mamba activate "$1"
  fi
}
