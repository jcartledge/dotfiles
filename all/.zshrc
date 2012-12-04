# Antigen
source ~/antigen/antigen.zsh
antigen-lib

antigen-bundle brew
antigen-bundle fasd
antigen-bundle gem
antigen-bundle git
antigen-bundle heroku
antigen-bundle npm
antigen-bundle ruby
antigen-bundle rvm
antigen-bundle sublime
antigen-bundle supki/zsh-cabal-completion
antigen-bundle vi-mode
antigen-bundle zsh-users/zsh-syntax-highlighting

antigen-theme git://gist.github.com/4182164.git gist-4182164

export DEFAULT_USER=e5020488

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi
if [[ -s ~/.rvm/bin/rvm-prompt ]] ; then
  RPROMPT='$(vi_mode_prompt_info) %{$fg_bold[green]%}$(~/.rvm/bin/rvm-prompt)'
fi

# Show completion on first TAB
setopt menucomplete

# Load completions for Ruby, Git, etc.
autoload compinit
compinit

PATH=$HOME/local/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# wrap git with hub: https://github.com/defunkt/hub
eval "$(hub alias -s)"

# Load github credentials for hub
if [[ -s ~/.github-credentials ]] ; then source ~/.github-credentials ; fi

