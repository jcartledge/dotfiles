alias o=open
alias telehack="telnet telehack.com"
function t {
  if [ $# -gt 0 ]; then
    todo.sh $@
  else
    todo.sh ls
    repl todo.sh
  fi
}
