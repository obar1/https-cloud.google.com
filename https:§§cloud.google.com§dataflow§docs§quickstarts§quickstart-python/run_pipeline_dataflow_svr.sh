export PROJECT_ID=qwiklabs-gcp-00-29431d5bf0ff
export GCP_REGION=us-central1
export STORAGE_BUCKET_ID=qwiklabs-gcp-00-29431d5bf0ff

python -m apache_beam.examples.wordcount \
--region $GCP_REGION \
--input gs://dataflow-samples/shakespeare/kinglear.txt \
--output gs://$STORAGE_BUCKET_ID/results/outputs  \
--runner DataflowRunner \
--project $PROJECT_ID \
--temp_location gs://$STORAGE_BUCKET_ID/tmp/
