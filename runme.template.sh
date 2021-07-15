#!/usr/bin/env bash

set -u
set -o pipefail

source "${BASE_PATH}"/tools.sh

### Do smething

function do_something() {
   echo "hello"
}

## Cleaning up

function cleaning_up() {
   echo '# gcloud xxx || true'
}

##
## params
##

case "${1}" in
1 | 'r')
   echo "run!" # function
   do_something
   ;;
2 | 'c')
   echo "cleanup!" #function
   cleaning_up
   ;;
*) helpme ;;
esac
