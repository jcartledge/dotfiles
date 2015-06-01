source "${HOME}/zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save"

  zgen oh-my-zsh

  zgen oh-my-zsh plugins/vi-mode
  zgen oh-my-zsh plugins/brew
  zgen oh-my-zsh plugins/bundler
  zgen oh-my-zsh plugins/fasd
  zgen oh-my-zsh plugins/gem
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/heroku
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/ruby
  zgen oh-my-zsh plugins/rvm
  zgen oh-my-zsh plugins/sublime
  zgen oh-my-zsh plugins/vagrant

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load supercrabtree/k
  zgen load sindresorhus/pure

  zgen save
fi

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi
if [[ -s ~/.rvm/bin/rvm-prompt ]] ; then
  RPROMPT='$(vi_mode_prompt_info) %{$fg_bold[green]%}$(~/.rvm/bin/rvm-prompt)'
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
PATH=$HOME/local/bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/local/share/npm/bin/:$PATH
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# wrap git with hub: https://github.com/defunkt/hub
eval "$(hub alias -s)"

# git file completion is hell of slow
# http://stackoverflow.com/questions/9810327/git-tab-autocompletion-is-useless-can-i-turn-it-off-or-optimize-it
__git_files () {
  _wanted files expl 'local files' _files
}

# gitignore.io
function gi() { curl https://www.gitignore.io/api/$@ ;}

# find replace
findrepl() {
  ack -l "$1" | xargs sed -i '' "s/$1/$2/g"
}

