#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## Creating a service account with a key

function create_sa() { #
   gcloud iam service-accounts create "$SA_OAUTH_API_ID" --display-name "$SA_OAUTH_API_ID"-display-name
}

function add_role2sa() { #
   gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:"$SA_OAUTH_API_ID@$PROJECT_ID.iam.gserviceaccount.com" --role 'roles/iam.serviceAccountTokenCreator'
}

function save_key_sa() { #
   gcloud iam service-accounts keys create SA_PRIVATE_KEY.json --iam-account "$SA_OAUTH_API_ID@$PROJECT_ID.iam.gserviceaccount.com"
}

## Creating a service account with a key

function create_api() { #
   gcloud api-gateway apis create $API_ID --project=$PROJECT_ID
}


function deploy_api_config() { #
   gcloud api-gateway api-configs create $API_CONFIG_ID --api=$API_ID --openapi-spec=$API_DEFINITION --project=$PROJECT_ID --backend-auth-service-account="$SA_OAUTH_API_ID@$PROJECT_ID.iam.gserviceaccount.com"
}

function describe_api_config() { #
   gcloud api-gateway api-configs describe $API_CONFIG_ID --api=$API_ID --project=$PROJECT_ID
}

function enble_api() { #
   gcloud services enable $API_ID-"${1}".apigateway.$PROJECT_ID.cloud.goog
}

function deploy_api_config_to_gatway() { #
   gcloud api-gateway gateways create $GATEWAY_ID --api=$API_ID --api-config=$API_CONFIG_ID --location=$GCP_REGION --project=$PROJECT_ID
}

function describe_gatway() { #
   echo 'defaultHostname'
   gcloud api-gateway gateways describe $GATEWAY_ID --location=$GCP_REGION --project=$PROJECT_ID
}



## Cleaning up

function cleaning_up() { #
   # Deleting a gateway
   gcloud api-gateway gateways delete $GATEWAY_ID --location=$GCP_REGION --project=$PROJECT_ID --async --quiet || true

   # delete api config
   gcloud api-gateway api-configs delete $API_CONFIG_ID --api=$API_ID --project=$PROJECT_ID --async --quiet || true

   # delete api
   gcloud api-gateway apis delete $API_ID --project=$PROJECT_ID --async --quiet || true
}

## Making an authenticated request to an API Gateway API

function client_invocation { #
   defaultHostname="http://${1}"
   python call.py $defaultHostname/hello $defaultHostname SA_PRIVATE_KEY.json "$SA_OAUTH_API_ID@$PROJECT_ID.iam.gserviceaccount.com"
}

function echo_curl_invoation() { #
   defaultHostname="http://${1}"
   TOKEN=123-abc
   echo curl --request GET --header "Authorization: Bearer ${TOKEN}" $defaultHostname/hello
}

set -x

# params

SA_OAUTH_API_ID=obar1-oauth-000-sa-id
API_DEFINITION='api-config-definition.yaml'

ID=obar1-oauth-001 

API_ID=$ID-api-id
API_CONFIG_ID=$ID-api-config-id
GATEWAY_ID=$ID-gateway-id
case "${1}" in
1 | 'r') ## run

   # create_sa
   # gcloud iam service-accounts list
   # add_role2sa
   # save_key_sa

   # create_api
   # deploy_api_config
   # describe_api_config
   # enble_api '0t5pd2sbheb8b'
   # deploy_api_config_to_gatway
   # describe_gatway

   ;;
2 | 'i') ## invocation
   client_invocation 'obar1-oauth-001-gateway-id-d6vhs2p6.uc.gateway.dev'
   echo_curl_invoation 'obar1-oauth-001-gateway-id-d6vhs2p6.uc.gateway.dev'
   ;;
3 | 'c') ## clean up

   cleaning_up

   ;;
*) info "$0" ;;
esac

set +x
