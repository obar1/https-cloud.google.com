#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## Configuring a service account

function enable_services() {
   gcloud services enable apigateway.googleapis.com
   gcloud services enable servicemanagement.googleapis.com
   gcloud services enable servicecontrol.googleapis.com
}
function configuring_service_account() {
   SERVICE_ACCOUNT_ID="${1}"
   ROLE_NAME="${2}"
   gcloud projects add-iam-policy-binding "${PROJECT_ID}" --member="serviceAccount:${SERVICE_ACCOUNT_ID}@${PROJECT_ID}.iam.gserviceaccount.com" --role="${ROLE_NAME}"
}

## Cleaning up

function cleaning_up() { #
   echo 'cleaning_up'
}

# params

case "${1}" in
1 | 'r') ## run
   # enable_services 
   configuring_service_account $SERVICE_ACCOUNT_ID 'roles/iam.serviceAccountUser'
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac
