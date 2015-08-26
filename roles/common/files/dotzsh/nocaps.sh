#!/usr/bin/env bash
#
# MANAGED BY CHEF IN wergstation::bashrc RECIPE.
# CHANGES WILL BE OVERWRITTEN!
#
# This temporarily remaps the CapsLock key to a Control key.
# The keyboard will return to the previous settings after a
# reboot. The Linux console and the X Window system each
# handles keypresses separately, so each must be remapped
# separately. First remap the X keyboard since this does not
# require root access.

# Remap the CapsLock key to a Control key for
# the X Window system.
if type setxkbmap >/dev/null 2>&1; then
        setxkbmap -layout us -option ctrl:nocaps 2>/dev/null
fi

# You have to be root to remap the console keyboard.
# Remap the CapsLock key to a Control key for the console.
#(dumpkeys | grep keymaps; echo "keycode 58 = Control") | loadkeys

