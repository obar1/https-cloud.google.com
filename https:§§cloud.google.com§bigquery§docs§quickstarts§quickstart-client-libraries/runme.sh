#!/usr/bin/env bash
set -u
set -o pipefail
# set -e
# v0.5

BASE_PATH=$(pwd -P)
export BASE_PATH
source "${BASE_PATH}/../_secrets/runme.sh"
source "${BASE_PATH}/../_tools/runme.sh"

## Do something

function do_something() { #
   export GCP_PROJECT="coherent-vim-317506"
   export GOOGLE_APPLICATION_CREDENTIALS="$HOME/SA_BASIC_OWNER_PRIVATE_KEY.json"
   python3 runme.py
}

## Cleaning up

function cleaning_up() { #
   echo 'cleaning_up'
}

# params

case "${1}" in
1 | 'r') ## run
   do_something
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac