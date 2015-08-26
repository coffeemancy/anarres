#!/usr/bin/env bash
#
# MANAGED BY CHEF IN wergstation::bashrc RECIPE.
# CHANGES WILL BE OVERWRITTEN!
#

__kitchen_instance_list () {
  echo "$(bundle exec kitchen list | awk '{print $1}'| perl -pe 's/\e\[?.*?[\@-~]//g'| grep -v Instance )"
}

__kitchen_options () {
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  COMPREPLY=()

  case $prev in
    login|converge|create|destroy|login|test|verify)
      COMPREPLY=( $(compgen -W "$(__kitchen_instance_list)" -- ${cur} ))
      return 0
      ;;
    driver)
      COMPREPLY=( $(compgen -W "create discover help"  -- ${cur} ))
      return 0
      ;;
    *)
      COMPREPLY=( $(compgen -W "console converge create destroy driver driver driver driver help init list login setup test verify version"  -- ${cur} ))
      return 0
      ;;
  esac
}

__kitchen_instances () {
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  COMPREPLY=()

  COMPREPLY=( $(compgen -W "$(__kitchen_instance_list)" -- ${cur} ))
  return 0
}

complete -F __kitchen_options kitchen
complete -F __kitchen_instances bekc
complete -F __kitchen_instances bekd
complete -F __kitchen_instances bekv
complete -F __kitchen_instances bekt
complete -F __kitchen_instances bekssh
