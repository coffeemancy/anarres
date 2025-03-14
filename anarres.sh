#!/usr/bin/env bash
# annares.sh
# 
# Helper script for running anarres.yaml with ansible-playbook.
#
# This script detects the existence of vars.yaml and vault.yaml, as well as become.pass
# and vault.pass, and sets up the appropriate arguments to pass to ansible-playbook.
#
# Any additional arguments passed to this script are passed through to ansible-playbook.
set -euo pipefail

ARGS=()

# build up other arguments to add to ansible-playbook
function build_args {
  # arguments to pass to ansible-playbook
  ARGS=("-i" "inv" "-u" "${USERNAME:-$USER}")

  if [[ -e "vars.yaml" ]]; then
    ARGS+=("-e" "@vars.yaml")
  fi

  if [[ -e "vault.yaml" ]]; then
    ARGS+=("-e" "@vault.yaml")

    if [[ -e "vault.pass" ]]; then
      ARGS+=("--vault-pass-file" "vault.pass")
    else
      ARGS+=("--ask-vault-pass")
    fi
  fi

  if [[ -e "become.pass" ]]; then
    ARGS+=("--become-pass-file" "become.pass")
  else
    ARGS+=("--ask-become-pass")
  fi

  # increase verbosity if DEBUG is set
  if [[ -n "${DEBUG:-}" ]]; then
    ARGS+=("-vv")
  fi
}

build_args
[[ -n "${DEBUG:-}" ]] && set -x
exec ansible-playbook anarres.yaml "${ARGS[@]}" "$@"
