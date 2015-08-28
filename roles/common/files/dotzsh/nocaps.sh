#!/usr/bin/env bash

# Remap the CapsLock key to a Control key for
# the X Window system.
if type setxkbmap >/dev/null 2>&1; then
        setxkbmap -layout us -option ctrl:nocaps 2>/dev/null
fi

# You have to be root to remap the console keyboard.
# Remap the CapsLock key to a Control key for the console.
#(dumpkeys | grep keymaps; echo "keycode 58 = Control") | loadkeys

