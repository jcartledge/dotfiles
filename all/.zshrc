# Antigen
source ~/antigen/antigen.zsh
antigen-lib

antigen-bundle vi-mode

antigen-bundle brew
antigen-bundle bundler
antigen-bundle fasd
antigen-bundle gem
antigen-bundle git
antigen-bundle heroku
antigen-bundle history-substring-search
antigen-bundle npm
antigen-bundle ruby
antigen-bundle rvm
antigen-bundle sublime
antigen-bundle vagrant
antigen-bundle zsh-users/zsh-syntax-highlighting

antigen-theme git://gist.github.com/4182164.git gist-4182164

if [[ -s /Users/jcartledge ]] ; then
  export DEFAULT_USER=jcartledge
elif [[ -s /Users/e5020488 ]] ; then
  export DEFAULT_USER=e5020488
fi

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi
if [[ -s ~/.rvm/bin/rvm-prompt ]] ; then
  RPROMPT='$(vi_mode_prompt_info) %{$fg_bold[green]%}$(~/.rvm/bin/rvm-prompt)'
fi

# Lazy cd
setopt autocd

# ugh
unsetopt correct

# History
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Load completions for Ruby, Git, etc.
autoload -U compinit
compinit

# zmv looks useful: http://strcat.de/zsh/#zmv
autoload -U zmv

# bind ctrl-r and esc-. emacs-style
bindkey '^R' history-incremental-search-backward
bindkey '^[.' insert-last-word

# path
PATH=$HOME/local/bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/local/share/npm/bin/:$PATH
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Load github credentials for hub
if [[ -s ~/Dropbox/.github-credentials ]] ; then source ~/Dropbox/.github-credentials ; fi

# wrap git with hub: https://github.com/defunkt/hub
eval "$(hub alias -s)"

# git file completion is hell of slow
# http://stackoverflow.com/questions/9810327/git-tab-autocompletion-is-useless-can-i-turn-it-off-or-optimize-it
__git_files () {
  _wanted files expl 'local files' _files
}

# gitignore.io
function gi() { curl http://gitignore.io/api/$@ ;}
