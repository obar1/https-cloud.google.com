#!/usr/bin/env bash

set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## Deploy a function

function deploy_function() { #
 `  cd helloworld || exit

   gcloud functions deploy hello_get \
      --runtime python39 --trigger-http --allow-unauthenticated
   cd ..`
}

## Test the function

function test_function() { #
   gcloud functions describe hello_get
}

## Delete the function

function delete_function() { #
   gcloud functions delete hello_get

}

# params

case "${1}" in
1 | 'r') ## run
   load_secrets
   set_region
   deploy_function
   test_function
   ;;
2 | 'c') ## clean up
   load_secrets
   delete_function
   ;;
*) info "$0" ;;
esac
