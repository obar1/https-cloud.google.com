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

function deploy_updated_api_config() { #
   gcloud api-gateway api-configs create $CONFIG_ID --api=$API_ID --openapi-spec=$API_DEFINITION --project=$PROJECT_ID --backend-auth-service-account="$SA_OAUTH_API_ID@$PROJECT_ID.iam.gserviceaccount.com"
}

# function enble_api() { #
#    gcloud services enable $API_ID-$HASH.apigateway.$PROJECT_ID.cloud.goog
# }

# function listing_api() { #
#    gcloud api-gateway api-configs list --project=$PROJECT_ID
# }

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
   API_ID=obar1-api-id
   CONFIG_ID=obar1-api-config-id-oauth
   API_DEFINITION='obar1-api-000.yaml'
   deploy_updated_api_config
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac
