if ! command -v brew >/dev/null; then
  brew_location="/home/linuxbrew/.linuxbrew/bin/brew"
  if [ -f $brew_location ]; then
    eval "$($brew_location shellenv)"
  fi
fi
