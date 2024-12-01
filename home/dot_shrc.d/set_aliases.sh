alias pvim='nvim -c $XDG_CONFIG_HOME/nvim-pluginless/init.vim'

alias eza="eza --icons=auto"
alias ezap="eza --colour=always --icons=always --classify=always | $PAGER"
alias fdp="fd --color always @args @PSBoundParameters | $PAGER"
alias rgp="rg --pretty @args @PSBoundParameters | $PAGER"
