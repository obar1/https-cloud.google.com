#!/usr/bin/env bash

set -u
set -o pipefail

# TODO:
# place in the current subfolder

# hands-on runme template
source "$BASE_PATH/tools.sh"
SECTION=https:§§cloud.google.com§dataflow§docs§guides§templates§using-flex-templates
export SECTION

ME='runme.sh'
export ME

### INFO

function helpme() {
   info "$BASE_PATH/$SECTION/$ME"
}

### INIT

function load_secrets() {
   source "$BASE_PATH"/secrets/runme.sh
}

function set_region() {
   export REGION="us-central1"
   gcloud config set compute/region "$REGION"
}

### Section
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
