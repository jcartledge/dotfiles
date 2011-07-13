# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# full color term so solarized works in regauler vim
export TERM=xterm-256color

# path for my bins
export PATH=/usr/local/bin:$PATH

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ Changed\ but\ not\ updated ]] || [[ "$git_status" =~ Untracked\ files ]] || [[ "$git_status" =~ Changes\ not\ staged ]] || [[ "$git_status" =~ Unmerged\ paths ]]; then
            local color="0;31" # red
        elif [[ "$git_status" =~ Changes\ to\ be\ committed ]]; then
            local color="0;32"
        else
            local color="1;32"
        fi
        echo -n '\[\033['$color'm\]$(__git_ps1)\[\033[0m\]'
    fi
}
function _prompt_command() {
    laststatus=$?
    PS1='\w'"`_git_prompt`"'\$\[\e[0m\] ';
    PS1="\[\033[1;32m\]\$(~/.rvm/bin/rvm-prompt | cut -d - -f 1,2 -)\[\033[0m\] $PS1"
    if [ $laststatus != 0 ]; then PS1="\[\033[1;31m\]($laststatus)\[\033[0m\] $PS1"; fi;
}
PROMPT_COMMAND=_prompt_command
