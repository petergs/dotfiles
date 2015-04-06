#
# ~/.bash_profile
#


[[ -f ~/.bashrc ]] && . ~/.bashrc

#export statements
export GOPATH=/home/pgs/gocode/
export PATH=$PATH:$GOPATH/bin

#automatically startx
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

