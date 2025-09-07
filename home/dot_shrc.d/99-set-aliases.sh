alias pvim='nvim -u $XDG_CONFIG_HOME/nvim-pluginless/init.vim'

# NOTE: These only work if the directory names do not contain \n.
# Even though fzf has an --read0 flag, posix find to not support --print0 flag.
if command -v eza >/dev/null 2>&1; then
  scd() {
    cd $(
      find . -type d -print 2>/dev/null | fzf --preview \
        'eza -G --colour=always --icons=always --classify=always {}' "$@"
    )
  }
  ucd() {
    cd $(
      find $HOME -type d -print 2>/dev/null | fzf --preview \
        'eza -G --colour=always --icons=always --classify=always {}' "$@"
    )
  }
else
  scd() {
    cd $(find . -type d -print 2>/dev/null | fzf --preview 'ls -C {}' "$@")
  }
  ucd() {
    cd $(find $HOME -type d -print 2>/dev/null | fzf --preview 'ls -C {}' "$@")
  }
fi

alias eza="eza --icons=auto"
ezap() {
  eza -G --colour=always --icons=always --classify=always "$@" | $PAGER
}
fdp() {
  fd --color always "$@" | $PAGER
}
rgp() {
  rg --pretty "$@" | $PAGER
}
difftp() {
  difft --color always "$@" | $PAGER
}
batf() {
  bat $(fzf "$@")
}
pagerf() {
  "$PAGER" $(fzf "$@")
}

alias dv='devour'
