# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug lib/directories, from:oh-my-zsh
zplug lib/history, from:oh-my-zsh

zplug plugins/asdf, from:oh-my-zsh
zplug plugins/fasd, from:oh-my-zsh
zplug plugins/git, from:oh-my-zsh
zplug plugins/git-flow, from:oh-my-zsh

zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions

zplug mafredri/zsh-async, from:github
zplug lukechilds/zsh-nvm, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

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
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# wrap git with hub: https://github.com/defunkt/hub
eval "$(hub alias -s)"
#
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv
eval "$(direnv hook zsh)"

# tmux
alias tmux="env TERM=xterm-256color tmux"

# nvim
alias vim=$EDITOR

# brew-wrap - updates Brewfile automatically.
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# config - for versioning config files in home dir
alias G='git --git-dir=$HOME/.cfg --work-tree=$HOME'

if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias nuget="mono /usr/local/bin/nuget.exe"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
