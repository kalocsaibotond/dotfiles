# Vi prompt editng
set -o vi

# Set shell prompt
case $SHELL_NAME in
'bash')
  PS1=$(echo $PS1 | sed "s/[^$]\\+\\$/\\[\\\\u@\\\\h \\\\W\\$\\] /")
  ;;
esac

# Zoxide initialisation
if ! command -v z >/dev/null && command -v zoxide >/dev/null; then
  case $SHELL_NAME in
  "zsh") eval "$(zoxide init zsh --hook prompt)" ;;
  "bash") eval "$(zoxide init bash --hook prompt)" ;;
  "ksh") eval "$(zoxide init ksh --hook prompt)" ;;
  "mksh") eval "$(zoxide init ksh --hook prompt)" ;;
  "oksh") eval "$(zoxide init ksh --hook prompt)" ;;
  *) eval "$(zoxide init posix --hook prompt)" ;;
  esac
fi

initialise_conda() {
  if [ -d "$2/anaconda3" ] &&
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

  # NOTE: This is the generalisation of what comes from conda init bash.
  __conda_setup="$("$anaconda_path/bin/conda" 'shell.bash' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$anaconda_path/etc/profile.d/conda.sh" ]; then
      . "$anaconda_path/etc/profile.d/conda.sh"
    else
      export PATH="$anaconda_path/bin:$PATH"
    fi
  fi
  unset __conda_setup

  if [ -n "$1" ]; then
    conda activate "$1"
  fi
}
