" If we're in a Git repo look for a .vimrc file at the top level.
let s:git_root = system('git rev-parse --show-toplevel')
if (v:shell_error == 0)
  let s:vimrc = substitute(s:git_root, '\n\+$', '', '') . '/.vimrc'
  if filereadable(s:vimrc)
    echo 'Sourcing ' . s:vimrc
    source `=s:vimrc`
  endif
endif
