#!/usr/bin/env bash

# find stuff and execute
function ffe {
  find ./* -type f -exec "$@" {} \;
}
