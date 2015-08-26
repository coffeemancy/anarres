#!/usr/bin/env bash

# start emacs server or connect to it if running
function e {
    # start emacs daemon if not running
    if ! ps aux | egrep 'emacs.*daemon' | grep -v grep > /dev/null; then
        printf "\e[35mStarting emacs daemon\e[00m\n"
        emacs --daemon 2>&1
    fi

    emacsclient -nw "$@"
}

function wtfgit {
    git log \
        --graph \
        --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' \
        --abbrev-commit \
        --date=relative
}

function wtf {
    # see if a git directory
    if [ -a .git ]; then
        wtfgit
    fi
}

# on 'cd' also list directory
function cd {
    builtin cd "$@"
    printf ">\e[33m$(pwd)\e[00m:\n"
    ls
}

# lookup gem on rubygems
function rbg {
    curl https://rubygems.org/api/v1/gems/$1.json 2>/dev/null | python -m json.tool
}

# get ruby gems version
function rbgv {
    rbg $1 | grep \"version\"
}

# find stuff and execute
function ffe {
  find ./* -type f -exec "$@" {} \;
}

# find emacs backup files and remove
function febr {
  find .* -type f -name '*#*' -exec rm -i {} \;
}

# find all ports vagrant is running on
function vports {
    for x in $(vagrant status | grep running | sed -e 's/\s.*//g'); do
        echo $x && vagrant ssh-config $x | grep -i port
    done
}

# xrandr helper
function xr {
    other=$1
    direction=${2:-left-of}

    # set up laptop screen
    printf "\e[35mSetting LVDS1 as auto\e[00m\n"
    xrandr --output LVDS1 --auto

    # set up other displays with direction, defaults to --left-of
    if [ "$other" ]; then
        printf "\e[35mSetting $other $direction LVDS1\e[00m\n"
        xrandr --output $other --auto --$direction LVDS1
    fi

    # disable any other outputs
    for another in DP1 HDMI1; do
        if [ "$another" != "$other" ]; then
            printf "\e[35mDisabling $another\e[00m\n"
            xrandr --output $another --off
        fi
    done
}

