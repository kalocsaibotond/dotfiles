# Vi prompt editng
set -o vi

# Set shell prompt
case $SHELL_NAME in
'bash')
  NEW_PS1='[\\u@\\h \\W\\$]'
  PS1=$(echo $PS1 | sed "s/[^$]\+\\$/$NEW_PS1/")
  ;;
esac

# Zoxide initialisation
if ! command -v z && command -v zoxide; then
  case $SHELL_NAME in
  "zsh") eval "$(zoxide init zsh --hook prompt)" ;;
  "bash") eval "$(zoxide init bash --hook prompt)" ;;
  "ksh") eval "$(zoxide init ksh --hook prompt)" ;;
  "mksh") eval "$(zoxide init ksh --hook prompt)" ;;
  "oksh") eval "$(zoxide init ksh --hook prompt)" ;;
  *) eval "$(zoxide init posix --hook prompt)" ;;
  esac
fi
