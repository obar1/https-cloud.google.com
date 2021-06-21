# Using Flex Templates

## Objective

create and run a flex template
with custom docker image
using the `gcloud` cmd line

## Costs

example going to use
DataflowPub/SubCloud StorageCloud SchedulerApp EngineContainer RegistryCloud BuildBigQuery

https://cloud.google.com/products/calculator

https://cloud.google.com/dataflow/pricing
![](2021-06-21-16-53-32.png)

small sample 
![](2021-06-21-16-58-17.png)

## Before you begin

- [X] enable api

Enable the Dataflow, Compute Engine, Logging, Cloud Storage, Cloud StorageJSON, BigQuery, Pub/Sub, Resource Manager, App Engine, Cloud Scheduler, andCloud Build APIs

https://console.cloud.google.com/flows/enableapi?apiid=dataflow,compute_component,logging,storage_component,storage_api,bigquery,pubsub,cloudresourcemanager.googleapis.com,appengine.googleapis.com,cloudscheduler.googleapis.com,cloudbuild.googleapis.com

![](2021-06-21-17-01-35.png)

FIXME: in the trial account 

- [X] create service account 

![](2021-06-21-17-10-10.png)

> delete the project when done to save money

create it `sa`
add `owner`

![](2021-06-21-17-15-28.png)

- [X] create new json key and save it 

![](2021-06-21-17-18-32.png)

- [X] set `GOOGLE_APPLICATION_CREDENTIALS`
