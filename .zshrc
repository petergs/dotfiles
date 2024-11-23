# prompt
PROMPT="%F{green}%n%f@%F{yellow}%m%f:[%F{magenta}%~%f] $> "

# set EDITOR
export EDITOR="vim"

# aliases
alias la="ls --la -G"
alias ls="ls -G"

# history settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE="(ls|ls *|cd|cd *|pwd|exit)"
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

# add ~/.local/bin to PATH
export PATH=~/.local/bin:$PATH

# stop ip a and get ifconfig
ip() {
    ifconfig
}

# unzip files from rtr
rtrunzip() {
    7z x $1 -p"infected"
}

short_prompt() {
    precmd() { print -rP "%F{magenta}%~%f" }
    export PROMPT="> "
}
