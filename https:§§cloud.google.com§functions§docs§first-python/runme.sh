#!/usr/bin/env bash
set -u
set -o pipefail
set -e
# v0.5

BASE_PATH=$(pwd)
export BASE_PATH
source "${BASE_PATH}/../_secrets/runme.sh"
source "${BASE_PATH}/../_tools/runme.sh"

### Deploying the function

function deploy_cf() { #
    gcloud functions deploy "$1" \
        --trigger-http \
        --region "$GCP_REGION" \
        --runtime python39 \
        --service-account "$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
        --no-allow-unauthenticated
}

### Testing the function

function info_cf_url() { #
    FUNCTION_URL=$(gcloud functions describe "$1" --region="$GCP_REGION" --format 'value(httpsTrigger.url)')
    echo $FUNCTION_URL
}

function ivoke_cf() { #
    FUNCTION_NAME=$1
    FUNCTION_URL=$2
    curl "https://$GCP_REGION-$PROJECT_ID.cloudfunctions.net/hello_http?$FUNCTION_NAME=$FUNCTION_URL"
}

### Viewing logs

function view_logs_cf() { #
    FUNCTION_NAME=$1
    gcloud functions logs read $FUNCTION_NAME
}

# params
set -x
case "${1}" in
1 | 'r') ## run
    FUNCTION_NAME=hello_http_param
    deploy_cf $FUNCTION_NAME
    FUNCTION_URL=$(info_cf_url $FUNCTION_NAME)
    echo $FUNCTION_URL
    # ivoke_cf $FUNCTION_NAME %FUNCTION_URL
    # view_logs_cf $FUNCTION_NAME
    ;;
2 | 'c') ## clean up
    cleaning_up
    ;;
*) info "$0" ;;
esac
set +x
