# prompt
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

# ensure ~/.local/bin is in PATH
PATH=~/.local/bin:~/go/bin:$PATH

# aliases
alias dev='cd ~/Documents/dev/'
alias ctf='cd ~/Documents/dev/ctf'
alias qtile-logs='tail -n 30 ~/.local/share/qtile/qtile.log'
alias qtile-reload='qtile cmd-obj -o cmd -f reload_config'
alias vim='nvim' 
alias hostname='hostnamectl hostname'

# ls defaults
alias la='ls -la --color=auto'
alias ls='ls --color=auto'

# grep color
alias grep='grep --color=auto'

# misc funcs
# compress_pdf in.pdf out.pdf
compress_pdf() {
    gs  -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$2 $1
}

# top 20 largest directories in $1
dud() {
    du -h $1 2> /dev/null | sort -n -r | head -n 20
}


# load additional environment variables
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

if [ -f "$HOME/.env" ]; then
    source ~/.env
fi

