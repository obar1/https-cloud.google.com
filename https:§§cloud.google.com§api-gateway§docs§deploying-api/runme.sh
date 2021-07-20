#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## Deploy an API config to a gateway

function deploy_api_config2gateway() { #
   gcloud api-gateway gateways create $GATEWAY_ID --api=$API_ID --api-config=$CONFIG_ID --location=$GCP_REGION --project=$PROJECT_ID
}

function gateway_details() { #
   gcloud api-gateway gateways describe $GATEWAY_ID --location=$GCP_REGION --project=$PROJECT_ID
}
## Cleaning up

function cleaning_up() { #
   echo 'cleaning_up'
}

# params

case "${1}" in
1 | 'r') ## run
   GATEWAY_ID=obar1-gateway-id
   API_ID=obar1-api-id
   CONFIG_ID=obar1-api-config-id
   deploy_api_config2gateway
   gateway_details
   # HASH=1y49d6sorvjcl
   # enble_api

   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac
