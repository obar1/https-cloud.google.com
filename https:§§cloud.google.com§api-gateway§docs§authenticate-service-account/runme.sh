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

function deploy_api_config() { #
   gcloud api-gateway api-configs create $API_CONFIG_ID --api=$API_ID --openapi-spec=$API_DEFINITION --project=$PROJECT_ID --backend-auth-service-account="$SA_OAUTH_API_ID@$PROJECT_ID.iam.gserviceaccount.com"
}

function listing_api() { #
   gcloud api-gateway api-configs list --project=$PROJECT_ID
}

function enble_api() { #
   HASH="${1}"
   echo gcloud services enable $API_ID-$HASH.apigateway.$PROJECT_ID.cloud.goog
}

## Cleaning up

function cleaning_up() { #
   echo '# gcloud xxx || true'
}

# params

case "${1}" in
1 | 'r') ## run
   SA_OAUTH_API_ID=sa-oauth-api-id
   # create_sa
   # gcloud iam service-accounts list
   # add_role2sa
   # save_key_sa
   API_ID=obar1-api-oauth-id
   API_CONFIG_ID=obar1-api-config-oauth-id
   API_DEFINITION='obar1-api-config-oauth.yaml'
   deploy_api_config
   listing_api
   # enble_api 370apjwx4b9zi
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac
