#!/usr/bin/env bash
set -u
set -o pipefail

source "${BASE_PATH}"/_core/tools.sh

## Creating a service account

function creating_service_account() { #
   SERVICE_ACCOUNT_ID="${1}"
   gcloud iam service-accounts create $SERVICE_ACCOUNT_ID --description="$SERVICE_ACCOUNT_ID-DESCRIPTION" --display-name="$SERVICE_ACCOUNT_ID-DISPLAY_NAME"
}

function list_sa() { #
   gcloud iam service-accounts list
}

function add_iam_role2sa() { #
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
   SERVICE_ACCOUNT_ID='a-dummy-sa'
   # creating_service_account $SERVICE_ACCOUNT_ID
   list_sa
   add_iam_role2sa $SERVICE_ACCOUNT_ID 'roles/logging.viewer'
   ;;
2 | 'c') ## clean up
   cleaning_up
   ;;
*) info "$0" ;;
esac
