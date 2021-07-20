#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## Do smething

function do_something() { #
   echo 'hello'
}

## Cleaning up

function cleaning_up() { #
   echo 'cleaning_up'
}

# # params

case "${1}" in
1 | 'r') ## run
   do_something
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac