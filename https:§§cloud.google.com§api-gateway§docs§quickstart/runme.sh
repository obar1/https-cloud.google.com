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

function deploy_func() { #
   # https://us-central1-coherent-vim-317506.cloudfunctions.net/hello_get
   echo "https-cloud.google.com.com.git/https:§§cloud.google.com§functions§docs§quickstart/runme.sh"
}

## Creating an API

function set_create_api() { # set api name
   API_ID='obar1-api-000'
   export API_ID
}

function create_api() { #
   gcloud api-gateway apis create $API_ID --project=$PROJECT_ID
}

function describe_api() { #
   gcloud api-gateway apis describe $API_ID --project=$PROJECT_ID
}

function set_deploy_api() { #
   API_CONFIG_ID='config-obar1-api-000'
   export API_CONFIG_ID
   API_CONFIG_YAML='obar1-api-000.yaml'
   export API_CONFIG_YAML
}

function deploy_sa() { #
   gcloud iam service-accounts add-iam-policy-binding \
      sa-528@coherent-vim-317506.iam.gserviceaccount.com \
      --member='serviceAccount:sa-528@coherent-vim-317506.iam.gserviceaccount.com' \
      --role='roles/iam.serviceAccountUser'
}

function deploy_api_config() { #
   gcloud api-gateway api-configs create $API_CONFIG_ID --api=$API_ID --openapi-spec=$API_CONFIG_YAML --project=$PROJECT_ID --backend-auth-service-account=sa-528@coherent-vim-317506.iam.gserviceaccount.com
}

function describe_api_config() { #
   gcloud api-gateway api-configs describe $API_CONFIG_ID --api=$API_ID --project=$PROJECT_ID
}

function set_create_gateway() { #
   GATEWAY_ID='gateway-obar1-api-000'
   export GATEWAY_ID
}
function create_gateway() { #
   gcloud api-gateway gateways create $GATEWAY_ID --api=$API_ID --api-config=$API_CONFIG_ID --location=$GCP_REGION --project=$PROJECT_ID
}

function describe_gateway() { #
   gcloud api-gateway gateways describe $GATEWAY_ID --location=$GCP_REGION --project=$PROJECT_ID
}

function test_deploy_api { #
   defaultHostname=gateway-obar1-api-000-d6vhs2p6.uc.gateway.dev
   curl https://$defaultHostname/hello
}

function enable_api_key { #
   defaultHostname=gateway-obar1-api-000-d6vhs2p6.uc.gateway.dev
   gcloud services enable obar1-api-000-1qwu701ni5m8l.apigateway.$PROJECT_ID.cloud.goog
}

function set_deploy_api_config_secure_api_key() { #
   API_ID_SECURE_API_KEY='obar1-api-000-secure-api-key'
   export API_ID_SECURE_API_KEY
   API_CONFIG_ID_SECURE_API_KEY='config-obar1-api-000-secure-api-key'
   export API_CONFIG_ID_SECURE_API_KEY
   API_CONFIG_YAML_SECURE_API_KEY='obar1-api-000-secure-api-key.yaml'
   export API_CONFIG_YAML_SECURE_API_KEY
}

function deploy_api_config_secure_api_key() { #
   gcloud api-gateway api-configs create $API_CONFIG_ID_SECURE_API_KEY --api=$API_ID_SECURE_API_KEY --openapi-spec=$API_CONFIG_YAML_SECURE_API_KEY --project=$PROJECT_ID --backend-auth-service-account=sa-528@coherent-vim-317506.iam.gserviceaccount.com
}

function update_existing_gateway() { #
   gcloud api-gateway gateways update $GATEWAY_ID --api=$API_ID --api-config=$API_CONFIG_ID_SECURE_API_KEY --location=$GCP_REGION --project=$PROJECT_ID
}

function test_deploy_api_config_secure_api_key() { #
   defaultHostname=gateway-obar1-api-000-d6vhs2p6.uc.gateway.dev
   curl https://$defaultHostname/hello?key=$API_KEY
}

## Cleaning up

function cleaning_up() { #
   gcloud api-gateway api-configs list --api=$API_ID --project=$PROJECT_ID
}

# params

case "${1}" in
1 | 'r') ## run
   # enabling_services
   # deploy_func
   set_create_api
   # create_api
   describe_api
   set_deploy_api
   # deploy_sa
   # deploy_api_config
   # describe_api_config
   set_create_gateway
   # create_gateway
   # describe_gateway
   # test_deploy_api
   # enable_api_key
   # set_deploy_api_config_secure_api_key
   # deploy_api_config_secure_api_key
   # set_create_api
   # update_existing_gateway
   # test_deploy_api
   test_deploy_api_config_secure_api_key
   ;;
2 | 'c') ## clean up
   set_create_api
   cleaning_up
   ;;
*)
   info "$0"
   ;;
esac
