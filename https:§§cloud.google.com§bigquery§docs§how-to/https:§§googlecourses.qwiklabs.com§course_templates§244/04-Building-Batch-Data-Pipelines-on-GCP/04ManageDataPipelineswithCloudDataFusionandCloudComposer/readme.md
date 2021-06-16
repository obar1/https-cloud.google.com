# 04ManageDataPipelineswithCloudDataFusionandCloudComposer


how to manage data pipelines with cloud data fusion and cloud composer
![](2020-11-12-12-57-03.png)
build data integration pipelines
> UX no code tool

![](2020-11-12-12-58-01.png)

![](2020-11-12-12-58-51.png)
behind the scenes it does deploy ephemeral execution env
supports data proc cluster where you can run spark batch and streaming
> cluster is ephemeral for the execution of the pipeline

you can use terraform to  avoid to  prevision cluster

![](2020-11-12-13-03-10.png)
define regions where to deploy the cluster

services run by dataflow
- pipeline lifecycle mng
- orchetsration
- coordination
- metadata mng

a long running but idle instance does not incur in charge over time
only get charged when actually running the pipeline

```
create instances in 
gke cluster 
inside tenant prj
```

create datafusion instance using
- gcp console

![](2020-11-12-13-08-28.png)
data fusion runs in containerized env with these 5 services each time // at least

df abstracts these for you so you can focus on the data analysis 

![](2020-11-12-13-11-24.png)
tou can test and debug each node of the pipeline

you cna tag each pipeline
use unified search to fins keyword in pipelines and schemas

data lineage is tracked 

![](2020-11-12-13-12-44.png)

![](2020-11-12-13-13-21.png)

focus on the `wrangler ui` and the `data pipeline`

more features
![](2020-11-12-13-14-00.png)

rules engine where BA can define checks
eng can use these rules in a pipeline

use metadata aggr to access each field in the UX
> create a data dictionary  for the schema


## Components of Data Fusion

let's check the UX now:

![](2020-11-12-13-49-54.png)

under control center multiple datapipeline associated with apps

you can see anc search what you need

![](2020-11-12-13-50-30.png)

![](2020-11-12-13-50-51.png)

![](2020-11-12-13-50-56.png)

![](2020-11-12-13-51-07.png)

![](2020-11-12-13-51-14.png)

![](2020-11-12-13-51-27.png)


## Building a Pipeline

hwo to build a pipeline

![](2020-11-12-13-52-09.png)
dag 
each stage is a node //diff types
ex
```
pull dat from cloud storage
parse the csv
join together
pass to 2 separate sinks 
```

![](2020-11-12-13-55-26.png)
a node can fork to avoid block
you cna combine data into 1  single output

![](2020-11-12-13-56-08.png)
studio is where you create the pipelines

- canvas = where you drag na drop the nodes
- minimap = to navigate huge pipeline
- canvas control panel
- pipeline actions toolbar 
> you can reuse pipeline

use `preview mode` you be sure of what it will run
you can click on the nodes to check the data and error
when running you get stats of the execution

ex
![](2020-11-12-13-58-38.png)
parse tweets and parsing them before loading in sinks
> use the tag feature

![](2020-11-12-13-59-10.png)
you can view start and overall summary 

use compute profile


![](2020-11-12-14-00-03.png)
clicking on the node
input 
outputs and errors
for the node

check anomalies looking 
```
rec/s
avg processing time
max processing time
```

you can setup the run on the pipeline at time schedules
def max # of concurrent times

![](2020-11-12-14-01-16.png)

> designed for batch pipeline

![](2020-11-12-14-01-42.png)


## Exploring Data using Wrangler

use wrangler to explore the ds
![](2020-11-12-14-03-33.png)

explorer insights in ds

![](2020-11-12-14-03-50.png)
def connection to ds
add new connection 
customer complaints sample
explore the data 
add calculated fields - drop  columns etc

def `data tr recipe` and use in the data pipeline to run in intervals

## Building and Executing a Pipeline Graph with Data Fusion


https://cloud.google.com/data-fusion/docs/how-to/create-instance

![](2020-11-12-15-47-40.png)

![](2020-11-12-15-50-01.png)

> Note: Creation of the instance can take around 15 minutes.

```
export BUCKET=$GOOGLE_CLOUD_PROJECT
gsutil mb gs://$BUCKET
gsutil cp gs://cloud-training/OCBL017/ny-taxi-2018-sample.csv gs://$BUCKET
```

Wrangler is an interactive, visual tool that lets you see the effects of transformations on a small subset of your data before dispatching large, parallel-processing jobs on the entire dataset. On the Cloud Data Fusion UI, choose Wrangler. On the left side, there is a panel with the pre-configured connections to your data, including the Cloud Storage connection.

### Task 2: Loading the data

![](2020-11-12-15-55-37.png)

`cloud-datafusion-management-sa@j315230980a2b65cdp-tp.iam.gserviceaccount.com`

click on `view instance`

![](2020-11-12-16-21-13.png)


![](2020-11-12-16-22-59.png)

### Task 3: Cleaning the data

![](2020-11-12-16-27-20.png)

![](2020-11-12-16-32-17.png)

![](2020-11-12-16-36-12.png)

joiner
![](2020-11-12-16-36-49.png)

sink
![](2020-11-12-16-39-34.png)

![](2020-11-12-16-42-34.png)

deploy
![](2020-11-12-16-53-14.png)

associated dataproc cluster
![](2020-11-12-16-56-42.png)

running 
![](2020-11-12-16-57-31.png)


## Orchestrating work between GCP services with Cloud Composer


![](2020-11-12-17-01-40.png)

![](2020-11-12-17-01-53.png)
ssas workflow runner //  apache aieflow

![](2020-11-12-17-02-09.png)

code is the dag

you can do a lot of things

## Apache Airflow Environment

![](2020-11-12-17-03-16.png)
cloud composer instance
> you can 1+ //e ach one separate airflow instance with related dags
```
specify projectid at airflow level
```

![](2020-11-12-17-04-10.png)
click on the link

2nd icon where the code is stored
gcs bucket


## DAGs and Operators


![](2020-11-12-17-04-51.png)
dag artifcat and operators

// 1 py file for each dag
![](2020-11-12-17-05-14.png)

![](2020-11-12-17-05-58.png)
visual rep of the code as nodes and edges

>task in py is a node here
```
3 tasks
and success and error 
```

operators
![](2020-11-12-17-09-00.png)
usually in 1 operator per task

![](2020-11-12-17-09-22.png)
bigquery op

TODO: check the operators

![](2020-11-12-17-10-01.png)
retrain and redeploy the model

![](2020-11-13-14-30-13.png)
airflow is open source 
new operator to new services added

https://airflow.apache.org/

ex of pipeline
![](2020-11-14-14-51-21.png)
4 task and 4 operators
1 and 2 to gte fresh model data from bigquery ds into gcs for ml consumption later

ex
![](2020-11-14-14-53-07.png)
top 100 most pop for a given date range

> the filter in the where clause are param in the sql statement


![](2020-11-14-14-53-59.png)
you can make param dynamic too if you want

![](2020-11-14-14-54-35.png)
op to retrain the model
and deploy the update model to app engine

ex
![](2020-11-14-14-54-57.png)
schedule jobs and sent in the automated wf
specify id for the task running and the prj top run on 

![](2020-11-14-14-57-03.png)
redeploy appengine prj with latest model
>just redeploy, less params

dependencies
![](2020-11-14-14-57-45.png)

t1 had to complete before t2 can run 
dependencies in the workflow

after you load the dag file in the folder you can see the graph in the airflow ui as graph/chart or list
> check the flow task order


## Workflow scheduling

after composer and task list in dag for airflow let's check the scheduling
- period //set schedule - once a day or on sat
- trigger based //wf to run when a new csv is loaded in a bucket or new data in a topic to which you are subscribed

![](2020-11-14-15-07-44.png)
2 dags

- composer sample simple has daily 

![](2020-11-14-15-08-20.png)
- the bigquery is driven by `cloud function`, there is no schedule

![](2020-11-14-15-08-43.png)
`schedule_inteval`

![](2020-11-14-15-09-06.png)

![](2020-11-14-15-09-34.png)
push event architecture

![](2020-11-14-15-09-48.png)
a lot of way to trigger on venets

![](2020-11-14-15-10-13.png)
ex ml wf with late arrival use push architecture
cloud storage trigger for our function

then def event type and 
![](2020-11-14-15-11-06.png)

![](2020-11-14-15-11-20.png)
code to run // js file

> a lot of boilerplate
// def func name 

![](2020-11-14-15-11-46.png)

![](2020-11-14-15-11-51.png)
which dag is used

be sure to specify the right dag

![](2020-11-14-15-12-24.png)
const to build the url to be used in the post req

def body of req

![](2020-11-14-15-12-53.png)
kick the rq to airflow

![](2020-11-14-15-13-37.png)

![](2020-11-14-15-14-02.png)
cloud func is active and monitor the bucket

> next section how to check it with monitor and logging


## Monitoring and Logging

![](2020-11-14-15-24-14.png)

![](2020-11-14-15-24-27.png)
investigate the historical runs of the wf

> you can define auto retry 

in the dag runs you can monitor the hsitorical run
> click from the dag page

ex
6 runs on the last 6 days

in the main page
![](2020-11-14-15-25-37.png)
200+ failure and 0 pass for the 1st dag

click on the name to get visual representation
![](2020-11-14-15-26-37.png)
1 is green 2 is red 3 is pink was skipped

to troubleshoot check the logs 
![](2020-11-14-15-27-23.png)
`invalid bucket name` for the output bucket

or
![](2020-11-14-15-27-49.png)
general gcp logs in stackdriver

check the normal gcp logs when using the cloud functions
// cloud function a re case sensitive 


![](2020-11-14-15-47-20.png)

![](2020-11-14-15-50-48.png)

![](2020-11-14-15-48-48.png)

https://airflow.apache.org/

Core concepts
https://airflow.apache.org/concepts.html#dags

A Directed Acyclic Graph is a collection of all the tasks you want to run, organized in a way that reflects their relationships and dependencies.

https://airflow.apache.org/concepts.html#operators

The description of a single task, it is usually atomic. For example, the BashOperator is used to execute bash command.

https://airflow.apache.org/concepts.html#tasks

A parameterised instance of an Operator; a node in the DAG.

https://airflow.apache.org/concepts.html#task-instances

A specific run of a task; characterized as: a DAG, a Task, and a point in time. It has an indicative state: running, success, failed, skipped, ...

You can read more about the concepts https://airflow.apache.org/concepts.html#


Note: Cloud Composer only schedules the workflows in the /dags folder.


![](2020-11-14-16-05-05.png)


![](2020-11-14-16-06-20.png)

![](2020-11-14-16-08-56.png)

![](2020-11-14-16-09-49.png)

![](2020-11-14-16-11-24.png)


![](2020-11-14-16-11-51.png)

check the logs
![](2020-11-14-16-12-50.png)

filter on airflow
![](2020-11-14-16-13-45.png)










