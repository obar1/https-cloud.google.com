export PROJECT_ID=123
export DATAFLOW_REGION_ID=europe-west1
export STORAGE_BUCKET_ID=%(PROJECT_ID)_BUCKET

python -m apache_beam.examples.wordcount 
--region DATAFLOW_REGION_ID
--input gs://dataflow-samples/shakespeare/kinglear.txt 
--output gs://STORAGE_BUCKET_ID/results/outputs 
--runner DataflowRunner
--project PROJECT_ID
--temp_location gs://STORAGE_BUCKET_ID/tmp/

 