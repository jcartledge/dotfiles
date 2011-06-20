alias o=open
alias telehack="telnet telehack.com"
function t {
  if [ $# -gt 0 ]; then
    todo.sh $@
  else
    echo; todo.sh ls; echo
    repl todo.sh
  fi
}
