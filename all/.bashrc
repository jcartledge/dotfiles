# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# full color term so solarized works in regauler vim
export TERM=xterm-256color

# path for my bins
export PATH=/usr/local/bin:/usr/local/share/python:$PATH

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load some dynamic aliases for dealing with remote hosts
if [ -f ~/.remote-aliases ]; then
    eval `~/.remote-aliases` 2>/dev/null
fi

# git aliases
if $(type -P git &>/dev/null) ; then
  for alias in $(git alias | awk '{print $1}'); do
    alias g${alias}="git $alias"
  done
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# prompt
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
    PS1="\[\033[1;32m\]\$(~/.rvm/bin/rvm-prompt | cut -d - -f 2,3 -)\[\033[0m\] $PS1"
    if [ $laststatus != 0 ]; then PS1="\[\033[1;31m\]($laststatus)\[\033[0m\] $PS1"; fi;
}

PROMPT_COMMAND=_prompt_command

# keep github credentials out of version control
if [ -f ~/.github ]; then
  . ~/.github
fi

# lol java
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/

# setup fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache"  ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# Setup wrappers for git (and other) aliases so tab completion works.
# Pasted from http://superuser.com/questions/436314/how-can-i-get-bash-to-perform-tab-completion-for-my-aliases
# Automatically add completion for all aliases to commands having completion functions
function alias_completion {
  local namespace="alias_completion"

  # parse function based completion definitions, where capture group 2 => function and 3 => trigger
  local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
  # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
  local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

  # create array of function completion triggers, keeping multi-word triggers together
  eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
  (( ${#completions[@]} == 0 )) && return 0

  # create temporary file for wrapper functions and completions
  rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
  local tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}.tmp")" || return 1

  # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
  local line; while read line; do
    eval "local alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error 
    local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

    # skip aliases to pipes, boolan control structures and other command lists
    # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
    eval "local alias_arg_words=($alias_args)" 2>/dev/null || continue

    # skip alias if there is no completion function triggered by the aliased command
    [[ " ${completions[*]} " =~ " $alias_cmd " ]] || continue
    local new_completion="$(complete -p "$alias_cmd")"

    # create a wrapper inserting the alias arguments if any
    if [[ -n $alias_args ]]; then
      local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
      # avoid recursive call loops by ignoring our own functions
      if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
        local compl_wrapper="_${namespace}::${alias_name}"
          echo "function $compl_wrapper {
            (( COMP_CWORD += ${#alias_arg_words[@]} ))
            COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
            $compl_func
          }" >> "$tmp_file"
          new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
      fi
    fi

    # replace completion trigger by alias
    new_completion="${new_completion% *} $alias_name"
    echo "$new_completion" >> "$tmp_file"
  done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
  source "$tmp_file" && rm -f "$tmp_file"
}; alias_completion


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
