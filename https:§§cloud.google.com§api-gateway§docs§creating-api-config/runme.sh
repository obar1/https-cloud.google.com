#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## API config ID requirements

function create_api_config() { #
   gcloud api-gateway api-configs create $CONFIG_ID --api=$API_ID --openapi-spec=$API_DEFINITION --project=$PROJECT_ID --backend-auth-service-account="$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com"
}

function describe_api_config() { #
 gcloud api-gateway api-configs describe $CONFIG_ID --api=$API_ID --project=$PROJECT_ID
}

function enble_api(){
gcloud services enable $API_ID-$HASH.apigateway.$PROJECT_ID.cloud.goog
}

function listing_api(){
   gcloud api-gateway api-configs list --project=$PROJECT_ID
}
## Cleaning up

function cleaning_up() { #
   echo 'cleaning_up'
}

# # params

case "${1}" in
1 | 'r') ## run
   API_ID=obar1-api-id
   CONFIG_ID=obar1-api-config-id
   API_DEFINITION='obar1-api-000.yaml'
   # create_api_config
   describe_api_config
   HASH=1y49d6sorvjcl
   # enble_api
   listing_api
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac
