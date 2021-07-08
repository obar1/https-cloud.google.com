# https:§§google.qwiklabs.com§quests§81

> https://google.qwiklabs.com/quests/81

## Fundamentals of Cloud Logging

https://google.qwiklabs.com/focuses/10911?parent=catalog

pdf [here](./qwiklabs.com-Fundamentals of Cloud Logging.pdf)

### Setup and requirements

N> this should be executed in the cloud shell
TODO: change the code to run in trial prj using  https-cloud.google.com.com.git/secrets approach

gcloud auth list

### Deploy the application

from https://github.com/GoogleCloudPlatform/getting-started-python get bookshelf

code bookshelf [here](./code/bookshelf)

req [here](./code/bookshelf/requirements.txt)

deploy the app

```
gcloud app deploy
```
### Setup your database

SWITCH TO NATIVE MODE

### Viewing and searching logs

### Log based metrics

https://cloud.google.com/logging/docs/logs-based-metrics/

### Create a counter metric

### Create a distribution metric

### View log metrics in the Cloud Monitoring Console

### Audit logging

### Exporting logs

### Other

https://cloud.google.com/logging/docs/reference/v2/rest/v2/LogEntry

## Using BigQuery and Cloud Logging to AnalyzeBigQuery Usage

pdf [here](./qwiklabs.com-Using BigQuery and Cloud Logging to Analyze BigQuery Usage.pdf)

### Setup Log Export from Cloud Logging

from Logs Explorer

### Create Sink

```
bq query --location=us --use_legacy_sql=false--use_cache=false ...
```
### Viewing the logs in BigQuery

define view 

## Cloud Logging on Kubernetes Engine

## Monitoring and Logging for Cloud Functions

## Creating and Alerting on Logs-based Metrics
