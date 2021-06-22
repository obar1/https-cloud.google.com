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

function set_region() {
   export REGION="us-central1"
   gcloud config set compute/region "$REGION"
}

set_region

function list_api() {
   # list enabled api
   gcloud services list
}

# list_api

### Create a Cloud Storage bucket

function set_bucket_vars(){
   export BUCKET_ID="my-storage-bucket-$PROJECT_ID"
}

set_bucket_vars

function create_bucket() {
   gsutil mb gs://"$BUCKET_ID"
}

# create_bucket

function list_bucket() {
   gsutil ls
   gsutil ls -r gs://"$BUCKET_ID"/**
}

# list_bucket || true

### Create a Pub/Sub topic and a subscription to that topic

function set_pub_sub_vars(){
   export TOPIC="messages"
   export SUBSCRIPTION="ratings"
}

set_pub_sub_vars

function create_pub_sub() {
   gcloud pubsub topics create $TOPIC
   gcloud pubsub subscriptions create --topic $TOPIC $SUBSCRIPTION
}

# create_pub_sub

### Create a Cloud Scheduler job

function create_scheduler_job() { # send pos and neg target msg to pub/sub
   gcloud scheduler jobs create pubsub positive-ratings-publisher \
   --schedule="*/2 * * * *" \
   --topic="$TOPIC" \
   --message-body='{"url": "https://beam.apache.org/", "review": "positive"}'

   gcloud scheduler jobs create pubsub negative-ratings-publisher \
   --schedule="*/5 * * * *" \
   --topic="$TOPIC" \
   --message-body='{"url": "https://beam.apache.org/", "review": "negative"}'
}

# create_scheduler_job

function run_scheduler_job(){
   gcloud scheduler jobs run positive-ratings-publisher
   gcloud scheduler jobs run negative-ratings-publisher
}

# run_scheduler_job

function delete_scheduler_job(){
   gcloud scheduler jobs delete positive-ratings-publisher
   gcloud scheduler jobs delete negative-ratings-publisher
}

# delete_scheduler_job

### Create a BigQuery dataset

function set_bigq_vars(){
   export DATASET="beam_samples"
   export TABLE="streaming_beam_sql"
}

set_bigq_vars

function mk_bigq(){
   bq mk --dataset "$PROJECT_ID:$DATASET"
}

# mk_bigq

## Python only: Creating and building a container image

function set_template_set_template(){
   export TEMPLATE_IMAGE="gcr.io/$PROJECT_ID/samples/dataflow/streaming-beam-sql:latest"
   export TEMPLATE_PATH="gs://$BUCKET_ID/samples/dataflow/templates/streaming-beam-sql.json"
}

set_template_set_template

function creating_and_building_container_image() {
   cd streaming_beam || exit

   gcloud config set builds/use_kaniko True
   gcloud builds submit --tag "$TEMPLATE_IMAGE" .
   gcloud builds list
   cd ..
}

# creating_and_building_container_image

## Creating a Flex Template
function creating_flex_template() {
   cd streaming_beam || exit
   gcloud dataflow flex-template build "$TEMPLATE_PATH" \
      --image "$TEMPLATE_IMAGE" \
      --sdk-language "PYTHON" \
      --metadata-file "metadata.json"
   cd ..
}

# creating_flex_template

## Running a Flex Template pipeline

function running_flex_template() {
  gcloud dataflow flex-template run "streaming-beam-$(date +%Y%m%d-%H%M%S)" \
    --template-file-gcs-location "$TEMPLATE_PATH" \
    --parameters input_subscription="projects/$PROJECT_ID/subscriptions/$SUBSCRIPTION" \
    --parameters output_table="$PROJECT_ID:$DATASET.$TABLE" \
    --region "$REGION"
}

# running_flex_template

function check_data_bq() {
   bq query --use_legacy_sql=false 'SELECT * FROM `'"$PROJECT_ID.$DATASET.$TABLE"'`'
}

# check_data_bq

## Cleaning up

function cleaning_up() {
   gcloud scheduler jobs delete negative-ratings-publisher || true
   gcloud scheduler jobs delete positive-ratings-publisher || true

   gcloud pubsub subscriptions delete $SUBSCRIPTION || true
   gcloud pubsub topics delete $TOPIC || true

   bq rm -f -t "$PROJECT_ID:$DATASET.$TABLE" || true

   bq rm -r -f -d "$PROJECT_ID:$DATASET" || true

   gsutil rm -r "gs://$BUCKET_ID" || true
}

cleaning_up