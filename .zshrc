# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug plugins/history-substring-search, from:oh-my-zsh
zplug plugins/vi-mode, from:oh-my-zsh
zplug plugins/fasd, from:oh-my-zsh
zplug plugins/git, from:oh-my-zsh
zplug plugins/heroku, from:oh-my-zsh
zplug plugins/vagrant, from:oh-my-zsh
zplug plugins/git-flow, from:oh-my-zsh

zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-autosuggestions

zplug mafredri/zsh-async
zplug sindresorhus/pure

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load

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
PATH=/usr/local/sbin:$PATH
PATH=/usr/local/share/npm/bin:$PATH

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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv
eval "$(direnv hook zsh)"

# tmux
alias tmux="env TERM=xterm-256color tmux"

# nvim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR='/usr/local/bin/nvim'
alias vim=$EDITOR

# brew-wrap - updates Brewfile automatically.
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# config - for versioning config files in home dir
alias config='hub --git-dir=$HOME/.cfg --work-tree=$HOME'
