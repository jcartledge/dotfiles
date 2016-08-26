source "${HOME}/zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save"

  zgen oh-my-zsh

  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/vi-mode
  zgen oh-my-zsh plugins/brew
  zgen oh-my-zsh plugins/fasd
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/heroku
  zgen oh-my-zsh plugins/vagrant
  zgen oh-my-zsh plugins/git-flow

  zgen load zsh-users/zsh-syntax-highlighting

  zgen load mafredri/zsh-async
  zgen load sindresorhus/pure

  zgen save
fi

# Lazy cd
setopt autocd

# ugh
unsetopt correct_all
unsetopt correct

# also seriously
unsetopt nomatch

# History
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Load completions for Ruby, Git, etc.
autoload -U compinit
compinit -u

# zmv looks useful: http://strcat.de/zsh/#zmv
autoload -U zmv

# bind ctrl-r and esc-. emacs-style
bindkey '^R' history-incremental-search-backward
bindkey '^[.' insert-last-word

# and fix history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# path
PATH=$HOME/.cabal/bin:$PATH
PATH=$HOME/.composer/vendor/bin:$PATH
PATH=$HOME/local/bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/local/share/npm/bin/:$PATH
PATH=/usr/local/php5/bin:$PATH

# wrap git with hub: https://github.com/defunkt/hub
eval "$(hub alias -s)"

# gitignore.io
function gi() { curl https://www.gitignore.io/api/$@ ;}

# enter = git status or ls
magic-enter () {
  if [[ -z $BUFFER ]]; then
    echo ""
    if git rev-parse --is-inside-work-tree &>/dev/null; then
      git status -s; git lg | head -5
    else
      ls -CF
    fi
    zle redisplay
  else
    zle accept-line
  fi
}
zle -N magic-enter
bindkey "^M" magic-enter

# todo.sh
alias t='todo.sh'
alias ta='todo.sh -t add'
alias td='todo.sh do'
alias tt='todo.sh ls && repl todo.sh -t'
alias te='todo.sh edit'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv
eval "$(direnv hook zsh)"

# nvim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR='/usr/local/bin/nvim'
alias vim=$EDITOR
