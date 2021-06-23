#!/usr/bin/env bash

# hands-on readme.md
source "$BASE_PATH/tools.sh"
SECTION=https:§§cloud.google.com§dataflow§docs§guides§templates§using-flex-templates
export SECTION

ME='runme.sh'
export ME

### INFO

function helpme() {
   info "$BASE_PATH/$SECTION/$ME"
}


### INIT

function load_secrets() {
   source "$BASE_PATH"/secrets/runme.sh
}

function set_region() {
   export REGION="us-central1"
   gcloud config set compute/region "$REGION"
}


### Create a Cloud Storage bucket

function set_bucket_vars(){
   export BUCKET_ID="my-storage-bucket-$PROJECT_ID"
}

function create_bucket() {
   gsutil mb gs://"$BUCKET_ID"
}

### Create a Pub/Sub topic and a subscription to that topic

function set_pub_sub_vars(){
   export TOPIC="messages"
   export SUBSCRIPTION="ratings"
}

function create_pub_sub() {
   gcloud pubsub topics create $TOPIC
   gcloud pubsub subscriptions create --topic $TOPIC $SUBSCRIPTION
}

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

function run_scheduler_job(){
   gcloud scheduler jobs run positive-ratings-publisher
   gcloud scheduler jobs run negative-ratings-publisher
}

### Create a BigQuery dataset

function set_bigq_vars(){
   export DATASET="beam_samples"
   export TABLE="streaming_beam_sql"
}

function mk_bigq(){
   bq mk --dataset "$PROJECT_ID:$DATASET"
}

## Python only: Creating and building a container image

function set_template_set_template(){
   export TEMPLATE_IMAGE="gcr.io/$PROJECT_ID/samples/dataflow/streaming-beam-sql:latest"
   export TEMPLATE_PATH="gs://$BUCKET_ID/samples/dataflow/templates/streaming-beam-sql.json"
}

function creating_and_building_container_image() {
   cd streaming_beam || exit

   gcloud config set builds/use_kaniko True
   gcloud builds submit --tag "$TEMPLATE_IMAGE" .
   gcloud builds list
   cd ..
}

## Creating a Flex Template

function creating_flex_template() {
   cd streaming_beam || exit
   gcloud dataflow flex-template build "$TEMPLATE_PATH" \
      --image "$TEMPLATE_IMAGE" \
      --sdk-language "PYTHON" \
      --metadata-file "metadata.json"
   cd ..
}

## Running a Flex Template pipeline

function running_flex_template() {
  gcloud dataflow flex-template run "streaming-beam-$(date +%Y%m%d-%H%M%S)" \
    --template-file-gcs-location "$TEMPLATE_PATH" \
    --parameters input_subscription="projects/$PROJECT_ID/subscriptions/$SUBSCRIPTION" \
    --parameters output_table="$PROJECT_ID:$DATASET.$TABLE" \
    --region "$REGION"
}

function echo_check_data_bq() {
   echo bq query --use_legacy_sql=false 'SELECT count(1) FROM `'"$PROJECT_ID.$DATASET.$TABLE"'`'
}

## Cleaning up

function cleaning_up() {
   gcloud scheduler jobs delete negative-ratings-publisher || true
   gcloud scheduler jobs delete positive-ratings-publisher || true

   gcloud pubsub subscriptions delete $SUBSCRIPTION || true
   gcloud pubsub topics delete $TOPIC || true

   echo 'delete gcloud dataflow flex-template run '

   bq rm -f -t "$PROJECT_ID:$DATASET.$TABLE" || true
   bq rm -r -f -d "$PROJECT_ID:$DATASET" || true

   gsutil rm -r "gs://$BUCKET_ID" || true
}

## 
## params
##

case "${1}" in 
  1|'r') echo "run!" # function
         load_secrets
         set_region
         set_bucket_vars
         create_bucket
         set_pub_sub_vars
         create_pub_sub
         create_scheduler_job
         run_scheduler_job
         set_bigq_vars
         mk_bigq
         set_template_set_template
         creating_and_building_container_image
         creating_flex_template
         running_flex_template
         echo_check_data_bq
       ;;
  2|'c') echo "cleanup!" #function
         load_secrets
         set_bigq_vars
         cleaning_up
       ;;
  *) helpme
esac



