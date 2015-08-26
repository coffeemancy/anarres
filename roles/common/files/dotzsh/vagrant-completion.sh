#!/usr/bin/env bash
#
# MANAGED BY CHEF IN wergstation::bashrc RECIPE.
# CHANGES WILL BE OVERWRITTEN!
#
# Add bash completion for vagrant 1.1+
# Uses vagrant status, which is pretty slow, but always works, instead of .vagrant

#!/bin/bash
__pwdln() {

   # Doing PE from the beginning of the string is needed
   # so we get a string of 0 len to break the until loop.

   pwdmod="${PWD}/"
   itr=0
   until [[ -z "$pwdmod" ]];do
      itr=$(($itr+1))
      pwdmod="${pwdmod#*/}"
   done
   echo -n $(($itr-1))

}

_vagrant()
{
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    commands="box destroy halt help init package provision reload resume ssh ssh-config status suspend up version"

    if [ $COMP_CWORD == 1 ]
    then
      COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
      return 0
    fi

    if [ $COMP_CWORD == 2 ]
    then
        case "$prev" in
            "init")
              local box_list=$(find $HOME/.vagrant.d/boxes -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
              COMPREPLY=($(compgen -W "${box_list}" -- ${cur}))
              return 0
            ;;
            "up")
              local box_list=$(vagrant status | tail -n +3 | grep .*\(.*\) | sed -e 's/\ .*\(.*\)$//')
              COMPREPLY=($(compgen -W "${box_list}" -- ${cur}))
              return 0
            ;;
            "ssh"|"provision"|"reload"|"destroy"|"halt"|"suspend"|"resume"|"ssh-config")
              local box_list=$(vagrant status | tail -n +3 | grep .*\(.*\) | grep -v 'not created' | sed -e 's/\ .*\(.*\)$//')
              COMPREPLY=($(compgen -W "${box_list}" -- ${cur}))
              return 0
            ;;
            "box")
              box_commands="add help list remove repackage"
              COMPREPLY=($(compgen -W "${box_commands}" -- ${cur}))
              return 0
            ;;
            "help")
              COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
              return 0
            ;;
            *)
            ;;
        esac
    fi

    if [ $COMP_CWORD == 3 ]
    then
      action="${COMP_WORDS[COMP_CWORD-2]}"
      if [ $action == 'box' ]
      then
        case "$prev" in
            "remove"|"repackage")
              local box_list=$(find $HOME/.vagrant.d/boxes -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
              COMPREPLY=($(compgen -W "${box_list}" -- ${cur}))
              return 0
              ;;
            *)
            ;;
        esac
      fi
    fi

}
complete -F _vagrant vagrant
#complete -o bashdefault -o default -o nospace -F _vagrant vagrant 2>/dev/null
