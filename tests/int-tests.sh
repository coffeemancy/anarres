#!/usr/bin/env bash
#
# Anarres integration tests.
#
# These tests require a working development environment (as described in README.md), as well as docker
# and docker-compose.

set -euo pipefail

# CLI arg defaults
VERBOSE="${VERBOSE:-}"

# update below to path to venv if different
VENV="${VENV:-.venv}"

function err { echo -e "\e[1;31mERROR:\e[0m\e[31m $1\e[0m"; }
function info { echo -e "\e[1;36m$1\e[0m"; }
function note { echo -ne "\e[34m$1\e[0m"; }
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
    else err "Failed to capture errors"; 
    fi
  fi
  if [[ -e "${TEMP_DIR:-}" ]]; then
    rm -r "${TEMP_DIR}"
  fi
  exit $ret
}

trap handle_exit exit

function compose_build {
  note "Building containers"
  if [[ -n "$VERBOSE" ]]; then
    echo
    docker-compose build 2>&1 | tee "${LAST_LOG}"
  else
    docker-compose build >"${LAST_LOG}" 2>&1
  fi
  success
}

function compose_up {
  note "Starting containers"
  if [[ -n "$VERBOSE" ]]; then
    echo
    docker-compose up -d 2>&1 | tee "${LAST_LOG}"
  else
    docker-compose up -d >"${LAST_LOG}" 2>&1
  fi
  success
}

function ansible_playbook {
  note "Running ansible-playbook"
  cmd="PATH=\$PATH:/home/user/.local/bin ansible-playbook anarres.yaml -i inv -u user -e @examples/vars.yaml -v"
  if [[ -n "$VERBOSE" ]]; then
    echo
    docker-compose exec -w /app -t app bash -c "$cmd" 2>&1 | tee "${LAST_LOG}"
  else
    docker-compose exec -w /app -t app bash -c "$cmd" >"${LAST_LOG}" 2>&1
  fi
  success
}

function usage {
	echo "int-tests.sh [OPTION]"
	echo "Run all integration tests using docker-compose"
	echo
	echo "  -v     verbose"
}

function run_integration_tests {
  info "Running integration tests..."

  # error out if docker-compose not in path
  if ! command -v docker-compose >/dev/null; then
    err "Missing docker-compose!" >"${LAST_LOG}"
    exit 1
  fi

  compose_build
  compose_up
  ansible_playbook
}

if [[ -d "${VENV:-}" ]]; then
  # shellcheck disable=SC1091
  source "${VENV}/bin/activate" >/dev/null 2>&1
fi

# process CLI args or show usage
while getopts "hv" arg; do
  case "$arg" in
    h)
      usage
      ;;
    v)
      VERBOSE=1
      ;;
    *)
      usage
      exit 1
  esac
done

run_integration_tests
