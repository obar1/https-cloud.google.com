#!/usr/bin/env bash

# hands-on readme.md
source '../tools.sh'
SECTION=https:§§cloud.google.com§dataflow§docs§guides§templates§using-flex-templates
ME='runme.sh'

### INFO

info "$BASE_PATH/$SECTION/$ME"

### INIT

function load_secrets() {
   source '../secrets/runme.sh'
}

load_secrets

function set_local() {
   gcloud config set compute/region us-central1
}

# set_local

function list_api() {
   # list enabled api
   gcloud services list
}

# list_api

### Create a Cloud Storage bucket

function create_bucket() {
   export BUCKET_ID="my-storage-bucket-$PROJECT_ID"
   gsutil mb gs://"$BUCKET_ID"
}

# create_bucket

function list_bucket() {
   gsutil ls

   export BUCKET_ID="my-storage-bucket-$PROJECT_ID"
   gsutil ls -r gs://"$BUCKET_ID"/**
}

list_bucket
