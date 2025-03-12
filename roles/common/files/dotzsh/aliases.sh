#!/usr/bin/env bash
 
# make sure to source functions.sh first, if exists
if [ -f "~/.zsh/functions.sh" ]; then
    source "~/.zsh/functions.sh"
fi

alias a="alias"
alias c="cat"
alias e="nvim"
alias df="df -h"
alias h="history"
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"
alias pong="ping www.google.com -c 1 -W 30"
alias pslag="ps -lA | head -n 1; ps -lA | grep -i"
alias rmcolors="sed -r \"s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g\""
alias t="tree -C"
alias vim="nvim"

