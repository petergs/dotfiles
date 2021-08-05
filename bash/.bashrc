# set EDITOR
export EDITOR="vim"

# enable bash completion
if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

# xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob

# append history file instead of creating a new one
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

# history environment variables
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export HISTIGNORE="ls:ll:la:cd:pwd"
export HISTTIMEFORMAT="[$(tput setaf 6)%F %T$(tput sgr0)]: " # colorful date

# prompt
#PS1='[\u@\h \W]\$ '  # Default
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

# load host specific bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ls defaults
alias la='ls -la --color=auto'
alias ls='ls --color=auto'

# ranger environment variables
export RANGER_LOAD_DEFAULT_RC=FALSE  # use home dir configuration files
