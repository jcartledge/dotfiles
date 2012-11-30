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

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Colors for prompt
autoload -U colors
colors

# vcs_info for prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' use-prompt-escapes true
zstyle ':vcs_info:git*' stagedstr "%{$fg_no_bold[green]%}"
zstyle ':vcs_info:git*' unstagedstr "%{$fg_no_bold[red]%}"

precmd() {
  if [[ -z $(git ls-files --other --exclude-standard -- $(git rev-parse --show-cdup 2>/dev/null) 2>/dev/null) ]] {
    untracked=''
  } else {
    untracked="%{$fg_no_bold[red]%}"
  }
  zstyle ':vcs_info:git*' formats "%{$fg_bold[green]%}%c%u$untracked(%b)%{$reset_color%}"
  zstyle ':vcs_info:git*' actionformats "%{$fg_bold[green]%}%c%u$untracked(%a|%b)%{$reset_color%}"
  vcs_info
}
setopt prompt_subst

# Prompt
PROMPT='%~ ${vcs_info_msg_0_}$ '
RPROMPT='$(vi_mode_prompt_info) %{$fg_bold[green]%}$(~/.rvm/bin/rvm-prompt)'

# Show completion on first TAB
setopt menucomplete

# Load completions for Ruby, Git, etc.
autoload compinit
compinit

PATH=$HOME/local/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# wrap git with hub: https://github.com/defunkt/hub
eval "$(hub alias -s)"
