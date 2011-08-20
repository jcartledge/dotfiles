alias o=open
alias telehack="telnet telehack.com"
function t {
  if [ $# -gt 0 ]; then
    todo.sh $@
  else
    echo; todo.sh ls; echo
    REPL_PROMPT="todo>> " repl todo.sh
  fi
}
