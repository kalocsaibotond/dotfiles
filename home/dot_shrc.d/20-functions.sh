# Implements cd on quit when using nnn.
# Source: https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_sh_zsh
nnn() {
  [ "${NNNLVL:-0}" -eq 0 ] || {
    echo "nnn is already running"
    return
  }

  NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  command nnn -c "$@"

  [ ! -f "$NNN_TMPFILE" ] || {
    . "$NNN_TMPFILE"
    rm -f -- "$NNN_TMPFILE" >/dev/null
  }

}

# This function copies the file content of an SSH remote system to the local
# system's clipboard.
# This function needs OSC 52 protocol support of the terminal emulator to work
# emulator to work.
# Through tmux this means the activation of clipboard allow-passthrough options.
osc52copy() {
  if [ -n "$1" ]; then
    if [ -f "$1" ]; then
      printf "\033]52;c;%s\033\\" "$(base64 -w 0 "$1")"
    else
      echo "Error: '$1' invalid file!" >&2
      return 1
    fi
  else
    printf "\033]52;c;%s\033\\" "$(base64 -w 0)"
  fi
}
