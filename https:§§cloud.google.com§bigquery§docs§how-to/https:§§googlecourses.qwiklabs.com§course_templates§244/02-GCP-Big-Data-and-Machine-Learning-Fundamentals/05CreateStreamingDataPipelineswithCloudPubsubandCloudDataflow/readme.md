# 05CreateStreamingDataPipelineswithCloudPubsubandCloudDataflow

## Modern Data Pipeline Challenges

until now batch ingestion, let's view what to do with msg streaming

![](2020-10-27-08-45-10.png)
msg
apache beam
visualize with dashboard

![](2020-10-27-08-46-58.png)
variety
game events
i/o
pos sales from storefront

volume
from gb to pb

velocity
near realtime when data arrives
transform and handle the late arrive


## Message-oriented Architectures with Cloud Pub/Sub

handling large volume of streaming data not from a db but from events and msg happening async

![](2020-10-27-08-48-07.png)
temperature sensors

we have to handle
- device who sent delayed, bad data
- allow in buffer
- subscribe to msg collected
- able to scale
- reliable, we need all the msg and possibly no dups

![](2020-10-27-08-49-18.png)
pub/sub = publisher and subscriber model

distributed msg service that receives msgs and ensure `at least once` delivery to subscribers
api is open
end to end encryption of the msg
global service

![](2020-10-27-08-50-15.png)
```
data ingest from devices
inegested in pub/sub  that stores mgs in topics
cloud dataflow as subscriber get the msg and it will output these in
bigquery for processing
data studio for visualization 
```

![](2020-10-27-08-52-07.png)
antenna is always there to capture the radio signal even no one is listening
listener are listening even when there in only  white noise

ex
![](2020-10-27-08-55-05.png)
diff source to send the same type of msgs
`decoupled sources`

![](2020-10-27-08-55-29.png)
all these systems subscriber independently get and process the same msg 
`decoupled workers`

pub/sub buffers the changes and reliable transfer msgs to the subscribers when they req

## Designing Streaming Pipelines with Apache Beam

![](2020-10-27-08-58-11.png)
- design 
? code is compatible with batch and streaming
? does sdk code have transformation (aggreg , windowing) and can handle late date in the pipeline
? is there any template to use

// ex apache beam


- implement
see later

![](2020-10-27-08-59-47.png)
is portable data processing programming model
unified = single model it can work for batch or streaming
portable = not locked in a vendor

![](2020-10-27-09-01-05.png)
runners pass the model to executors // dataflow is a runner


![](2020-10-27-09-01-36.png)
ex
filter - group - compare -join
// in parallel use od `ProcessContext`

![](2020-10-27-09-02-32.png)
you can deploy on appengine to execute the pipeline

## Implementing Streaming Pipelines on Cloud Dataflow

![](2020-10-27-09-03-28.png)

questions are solved with cloduflow as
- little
- built on google 
- autoscale workers
- integrated with stackdriver
- use spark/cloudflow etc

![](2020-10-27-09-05-15.png)
you can run all the hadoop dataflow with cloud flow

data flow is serverless 
// resource managed 
// pipeline is reliable

![](2020-10-27-09-06-10.png)
```
let's see what happens when a job is submitted
cloud dataflow service optimize the execution graph 
schedules the work allocating the executors
oit will auto-heal if workers died
rebalance to optimize the load 
put dat in the sinks

```


![](2020-10-27-09-07-52.png)
these are templates you canstart with 

https://github.com/GoogleCloudPlatform/DataflowTemplates


![](2020-10-27-09-08-54.png)
recap
// query per second


## Visualizing Insights with Data Studio

stakeholders want to interact with the data to explore the data or present the result

![](2020-10-27-09-10-09.png)
use `explore in datastudio`

![](2020-10-27-09-10-35.png)
ex 
of the tv ad on the olympics
tell a good story about the data

the fact someone can access your dashboard does not mean can see the data automatically 

https://datastudio.google.com/

you can use template
tell where the data is from
`data source picker`

![](2020-10-27-09-12-51.png)

## Creating Charts with Data Studio
`click and draw` to place the chart
click view to see what viewers can see

![](2020-10-27-09-14-08.png)
live data so the graph changes

- dimension are green //categories
- metrics are blue // count 
- calculated fields can be both from dim or metrics

![](2020-10-27-09-15-05.png)

underlying data must be granted // not sone automatically when you share the report

## Demo - Data Studio Walkthrough

![](2020-10-27-09-16-06.png)

![](2020-10-27-09-16-48.png)
visualize as bar

![](2020-10-27-09-17-12.png)
add a filter // like a where condition

## Lab - Real-time IoT Dashboards with Pub/Sub, Dataflow, and Data Studio

end to end on sensor data and report in ral time
- def a topic 
- def a dataflow job and subscribe to the topic
- run the job and monitor the output in the sink // bigquery
- use views to visualize the data
- build dashboard to render the data in realtime 


## Creating a Streaming Data Pipeline for a Real-Time Dashboard with Dataflow


### Note your project name; confirm that needed APIs are enabled

![](2020-10-27-09-46-00.png)
and dataflow

Pub/Sub is an asynchronous global messaging service. By decoupling senders and receivers, it allows for secure and highly available communication between independently written applications. Pub/Sub delivers low-latency, durable messaging.

In Pub/Sub, publisher applications and subscriber applications connect with one another through the use of a shared string called a topic. A publisher application creates and sends messages to a topic. Subscriber applications create a subscription to a topic to receive messages from it.

### Task 1. Create a Pub/Sub topic and BigQuery dataset


https://cloud.google.com/pubsub/
https://opendata.cityofnewyork.us/
https://cloud.google.com/bigquery/

```
bq mk taxirides

Dataset 'qwiklabs-gcp-01-6dce59947e80:taxirides' successfully created
```

![](2020-10-27-09-48-45.png)

```
bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime

Table 'qwiklabs-gcp-01-6dce59947e80:taxirides.realtime' successfully created.
```

### Option 2: The BigQuery Console UI

BigQuery is a serverless data warehouse. Tables in BigQuery are organized into datasets. In this lab, messages published into Pub/Sub will be aggregated and stored in BigQuery.


https://cloud.google.com/bigquery/docs/partitioned-tables?_ga=2.232838296.-723080937.1603787946

![](2020-10-27-09-51-51.png)

### Task 2. Create a Cloud Storage bucket

https://cloud.google.com/storage/

Cloud Storage allows world-wide storage and retrieval of any amount of data at any time

![](2020-10-27-09-53-48.png)


## Task 3. Set up a Dataflow Pipeline

https://cloud.google.com/dataflow/

Dataflow is a serverless way to carry out data analysis

![](2020-10-27-09-57-12.png)

![](2020-10-27-09-59-26.png)

![](2020-10-27-10-00-11.png)


### Task 4. Analyze the taxi data using BigQuery

```
SELECT * FROM taxirides.realtime LIMIT 10
```



### Task 5. Perform aggregations on the stream for reporting

```sql
WITH streaming_data AS (

SELECT
  timestamp,
  TIMESTAMP_TRUNC(timestamp, HOUR, 'UTC') AS hour,
  TIMESTAMP_TRUNC(timestamp, MINUTE, 'UTC') AS minute,
  TIMESTAMP_TRUNC(timestamp, SECOND, 'UTC') AS second,
  ride_id,
  latitude,
  longitude,
  meter_reading,
  ride_status,
  passenger_count
FROM
  taxirides.realtime
WHERE ride_status = 'dropoff'
ORDER BY timestamp DESC
LIMIT 100000

)

# calculate aggregations on stream for reporting:
SELECT
 ROW_NUMBER() OVER() AS dashboard_sort,
 minute,
 COUNT(DISTINCT ride_id) AS total_rides,
 SUM(meter_reading) AS total_revenue,
 SUM(passenger_count) AS total_passengers
FROM streaming_data
GROUP BY minute, timestamp
```


### Task 6. Create a real-time dashboard

Click Explore Data > Explore with Data Studio in BigQuery page.

https://datastudio.google.com/navigation/reporting

![](2020-10-27-10-03-54.png)

![](2020-10-27-10-13-20.png)
ex

### Task 7. Create a time series dashboard


![](2020-10-27-10-16-40.png)

From the list of Google Connectors, select the BigQuery tile

custom query 

```sql
SELECT
  *
FROM
  taxirides.realtime
WHERE
  ride_status='dropoff'
```


![](2020-10-27-10-17-20.png)


![](2020-10-27-10-24-02.png)

view

![](2020-10-27-10-24-07.png)


### my version ;)

![](2020-10-27-10-32-32.png)
![](2020-10-27-10-32-36.png)

[here](./Untitled_Report.pdf)















