#!/usr/bin/env bash
#
# Anarres local tests.
#
# Equivalent to tests run on PRs by Github Actions as defined in .github/workflows/pr-*.yaml files.
# 
# These tests require a working development environment (as described in README.md).

set -euo pipefail

# update below to path to venv if different
VENV=".venv"

function missing_command { echo -e " \e[40m (missing command)\e[0m"; }
function skip_command { echo -e " \e[1;35m?\e[0m"; }
function success { echo -e " \e[1;30m✔\e[0m"; }

TEMP_DIR="$(mktemp -d)"
LAST_LOG="${TEMP_DIR}/last.log"
export LAST_LOG

function handle_exit {
  ret=$?
  if (( ret != 0 )); then
    echo -e " \e[1;31m✗\e[0m"
    if [[ -e "${LAST_LOG:-}" ]]; then less "${LAST_LOG}" 1>&2;
    else echo -e "\e[31mFailed to capture errors\e[0m"; 
    fi
  fi
  if [[ -e "${TEMP_DIR:-}" ]]; then
    rm -r "${TEMP_DIR}"
  fi
  exit $ret
}

trap handle_exit exit

# pre-commit functions

function test_ansible_lint {
  echo -ne "\e[36mansible-lint\e[0m"
  if [[ -n "${SKIP_ANSIBLE_LINT:-}" ]]; then skip_command; return; fi
  ansible-lint >"${LAST_LOG}" 2>&1
  success
}

function test_shellcheck {
  echo -ne "\e[36mshellcheck\e[0m "
  if [[ -n "${SKIP_SHELLCHECK:-}" ]]; then skip_command; return; fi
  if ! command -v shellcheck >/dev/null; then missing_command; return; fi
  find ./* -type f -name "*.sh" -print0 | xargs -0 --no-run-if-empty shellcheck >"${LAST_LOG}" 2>&1
  success
}

function test {
  test_ansible_lint
  test_shellcheck
}

if [[ -d "${VENV:-}" ]]; then
  # shellcheck disable=SC1091
  source "${VENV}/bin/activate" >/dev/null 2>&1
fi

test
