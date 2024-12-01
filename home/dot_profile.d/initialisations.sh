if ! command -v brew; then
  brew_location="/home/linuxbrew/.linuxbrew/bin/brew"
  if [ -f $brew_location ];
    eval "$($brew_location shellenv)"
  fi
fi
