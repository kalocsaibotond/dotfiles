alias pvim='nvim -c $XDG_CONFIG_HOME/nvim-pluginless/init.vim'

alias eza="eza --icons=auto"
ezap() {
  eza --colour=always --icons=always --classify=always "$@" | $PAGER
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
