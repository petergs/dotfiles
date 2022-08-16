# prompt
#PS1='[\u@\h \W]\$ '  # Default
#PS1='\[\e[1;32m\][\u@\h] \w\[\e[0m\]\n\$ '
set_ps1() {
    local start="\[$(tput bold)\]\[\033[38;5;2m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]"
    local host=""
    if [[ $SSH_TTY ]] 
    then
        host="\[$(tput bold)\]\[\033[38;5;5m\]\h\[$(tput sgr0)\]"
    else
        host="\[$(tput bold)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\]"
    fi
    local end=":[\[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]] \$> \[$(tput sgr0)\]"
    echo "${start}${host}${end}"
}
#PS1="\[$(tput bold)\]\[\033[38;5;2m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\]:[\[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]] \$> \[$(tput sgr0)\]"
PS1=$(set_ps1)

# set EDITOR
export EDITOR="vim"

# enable bash completion
if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

# optional shell behaviors
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s histverify
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

# history environment variables
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export HISTIGNORE="ls:ll:la:cd:pwd"
export HISTTIMEFORMAT="[$(tput setaf 6)%F %T$(tput sgr0)]: " # colorful date

# load host specific bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ls defaults
alias la='ls -la --color=auto'
alias ls='ls --color=auto'

# ensure ~/.local/bin is in PATH
PATH=~/.local/bin:$PATH

# other aliases
alias hostname='hostnamectl hostname'
if [[ $TERM='xterm-kitty' ]]
then
    alias kssh="kitty +kitten ssh"
fi

# misc funcs
# compress_pdf in.pdf out.pdf
compress_pdf() {
    gs  -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$2 $1
}
