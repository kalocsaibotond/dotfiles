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
