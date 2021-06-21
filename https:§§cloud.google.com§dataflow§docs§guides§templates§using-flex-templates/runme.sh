#!/usr/bin/env bash

# basic scripts for readme.md

### INIT

set -eu
# set -x #verbose 
 
check_secrets() {
   source '../secrets/runme.sh'
   echo "$PROJECT_ID"
   echo "$GOOGLE_APPLICATION_CREDENTIALS"
}

check_secrets

set_local(){ 
   gcloud config set compute/region us-central1

# # list enabled api
# gcloud services list
}

set_local

### Create a Cloud Storage bucket

export BUCKET="my-storage-bucket-$PROJECT_ID"
gsutil mb gs://"$BUCKET"
