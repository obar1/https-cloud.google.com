#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## Api mng

function create_api() { #
   gcloud api-gateway apis create "$API_ID" --project="$PROJECT_ID" --async --display-name="$API_ID"_test
}

function describe_api() { #
   gcloud api-gateway apis describe "$API_ID" --project="$PROJECT_ID"
}

## Cleaning up

function cleaning_up() { #
   gcloud api-gateway apis delete "$API_ID" --project="$PROJECT_ID"
}

# # params

case "${1}" in
1 | 'r') ## run
   API_ID=obar1-api-id
   # create_api
   describe_api
   ;;
2 | 'c') ## clean up
   API_ID=obar1-api-id
   cleaning_up
   ;;
*) info "$0" ;;
esac
