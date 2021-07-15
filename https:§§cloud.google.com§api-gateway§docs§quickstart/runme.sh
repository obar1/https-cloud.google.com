#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/tools.sh

### Enabling required services

function enabling_services() { #
   gcloud services enable apigateway.googleapis.com
   gcloud services enable servicemanagement.googleapis.com
   gcloud services enable servicecontrol.googleapis.com
}

function deploy_func() {
   # https://us-central1-coherent-vim-317506.cloudfunctions.net/hello_get
   echo "/Users/mamat/git/obar1/https-cloud.google.com.com.git/https:§§cloud.google.com§functions§docs§quickstart/runme.sh"
}

## Creating an API

function set_api() { # set api name
   API_ID='obar1-api-000'
   export API_ID
}

function creating_api() {
   gcloud api-gateway apis create $API_ID --project=$PROJECT_ID
}

function describe_api() {
   gcloud api-gateway apis describe $API_ID --project=$PROJECT_ID
}


function set_deploy_api() {
   API_CONFIG_ID='config-obar1-api-000'
   export API_CONFIG_ID
   API_CONFIG_YAML='obar1-api-000.yaml'
   export API_CONFIG_YAML
}

function deploy_sa() {
   gcloud iam service-accounts add-iam-policy-binding \
      sa-528@coherent-vim-317506.iam.gserviceaccount.com \
      --member='serviceAccount:sa-528@coherent-vim-317506.iam.gserviceaccount.com' \
      --role='roles/iam.serviceAccountUser'

 
}

function deploy_api() {
   gcloud api-gateway api-configs create $API_CONFIG_ID --api=$API_ID --openapi-spec=$API_CONFIG_YAML --project=$PROJECT_ID --backend-auth-service-account=sa-528@coherent-vim-317506.iam.gserviceaccount.com
}
## Cleaning up

function cleaning_up() { #
   echo '# gcloud xxx || true'
}

# params

case "${1}" in
1 | 'r') ## run
   # enabling_services
   # deploy_func
   set_api
   # creating_api
   describe_api
   set_deploy_api
   # deploy_sa
   deploy_api
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac
