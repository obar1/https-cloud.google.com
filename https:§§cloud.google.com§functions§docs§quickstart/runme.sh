#!/usr/bin/env bash

# hands-on readme.md
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

## Deploy a function

function deploy_function() {
   cd helloworld || exit

   gcloud functions deploy hello_get \
      --runtime python39 --trigger-http --allow-unauthenticated
   cd ..
}

## Test the function

function test_function() {
   gcloud functions describe hello_get
}

## Delete the function

function delete_function() {
   gcloud functions delete hello_get

}

##
## params
##

case "${1}" in
1 | 'r')
   echo "run!" # function
   load_secrets
   set_region
   deploy_function
   test_function
   ;;
2 | 'c')
   echo "cleanup!" #function
   load_secrets
   delete_function
   ;;
*) helpme ;;
esac
