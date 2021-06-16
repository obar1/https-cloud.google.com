# 06AdvancedBigQueryFunctionalityandPerformance

![](2020-12-07-18-29-46.png)

![](2020-12-07-18-30-37.png)

![](2020-12-07-18-31-45.png)
3 Biz questions 

![](2020-12-07-18-32-13.png)

![](2020-12-07-18-32-18.png)
2 tables

![](2020-12-07-18-32-37.png)
use duration field

![](2020-12-07-18-32-56.png)
distance calculation
we have names 

![](2020-12-07-18-33-11.png)
we have long and lat and we can use `ST_DISTANCE`

![](2020-12-07-18-35-50.png)

![](2020-12-07-18-36-40.png)
get data from 2 tbl
> use `STRUCT`

![](2020-12-07-18-37-18.png)
result of join 
> denormlaitzaiton
ok as data is saved in columanr storage

![](2020-12-07-18-37-58.png)
get gis point
ex
661 meters


![](2020-12-07-18-38-23.png)
use sql to cal the Biz answers

![](2020-12-07-18-39-03.png)
output

![](2020-12-07-18-39-37.png)
use `geoviz`

## Demo:GIS Functions and Mapping with BigQuery

![](2020-12-07-18-40-08.png)

## WITH Clauses vs Permanent Tables

![](2020-12-07-18-41-19.png)
use `WITH` to create named subquery
chain more than 1 with a comma

![](2020-12-07-18-42-38.png)
predicate pushdown

![](2020-12-07-18-43-31.png)

## Analytical window functions

![](2020-12-07-18-44-05.png)


![](2020-12-07-18-44-19.png)
ts come in and come out and time sat in the docker
// look back in time 

![](2020-12-07-18-45-02.png)

![](2020-12-07-18-45-30.png)

diff from 1 record before

![](2020-12-07-18-46-16.png)

![](2020-12-07-18-47-02.png)
array

![](2020-12-07-18-47-10.png)
bike stats

![](2020-12-07-18-47-24.png)
use rank

![](2020-12-07-18-47-52.png)

![](2020-12-07-18-48-28.png)
bike to be mantained

![](2020-12-07-18-50-11.png)
bike_id with any single trip taken by the bike
rank() is analytical func
sum() is aggr func

![](2020-12-07-18-52-37.png)

![](2020-12-07-18-53-42.png)

drill into details with `ARRAY_AGG`

![](2020-12-07-18-54-16.png)

with array agg you have multiple level of aggr

![](2020-12-07-18-54-27.png)

## Lab Intro:Optimizing your BigQuery Queries for Performance

![](2020-12-07-18-55-34.png)


see sql in 
05-Building-Resilient-Streaming-Analytics-Systems-on-GCP\06AdvancedBigQueryFunctionalityandPerformance\lab01.pdf

## Performance Considerations

![](2020-12-07-19-08-18.png)

![](2020-12-07-19-08-46.png)

![](2020-12-07-19-10-21.png)
Toggle Cour we'll close this module with recap on  bigquery performance and pricing topics  there are five key areas for performance  optimization in bigquery and they are  input/output how many bytes were read  from disk shuffling how many bytes were  passed to the next query processing  stage grouping how many bytes were  passed through to each group  materialization how many bytes were  written permanently out to disk and  lastly functions and UDF's  how computationally expensive is the  query on your CPU here's a cheat sheet  of best practices that you should follow  starting from the top don't select more  data columns than you need that means  avoid select star at all costs when you  can if you have a super huge data set  consider using approximate aggregation  functions instead of regular ones  next make liberal use of the where  Clause at all times to filter data then  don't have an order by on a with clause  or sub queries or any other sub queries  that you have only order is the last  thing that you do for joins put the  larger table on the Left if you can  that'll help bigquery optimize it and  how it does its joins if you forget  bigquery will likely do those  authorizations for you so you might not  even see any difference you can use  wildcards in table suffixes to query  multiple tables but try to be as  specific as possible as you can with  those wild cards for your group buys if  you're grouping by the names of every  Wikipedia author ever which means high  distinct values or high cardinality  that's a bad practice for an  anti-pattern stick to low unique value  group bys lastly use partition tables  when you can you'll practice creating  these in a lab later 

![](2020-12-07-19-11-02.png)
there are two major  ways to partition tables in bigquery  when you first ingest the data as a  destination table or is an actual column  that you can partition on the first  example shows that you can create a  table with ingestion time partitioning  by day  and the other two examples show how to  promote an already-existing comment you  have in a data set to be a partitioned  column the columns must be of type dates  timestamp our newly added as an integer  range column 



![](2020-12-07-19-11-14.png)
partitioning can improve  query cost and performance by reducing  the amount of data that's scanned since  bigquery is access to the partition  metadata it can avoid partitions of data  that it knows will be of zero value to  the query asked like ignoring all data  before a certain date filter as you can  see here   


## Partitioned Tables in Google BigQuery


```sql
#standardSQL
SELECT DISTINCT
  fullVisitorId,
  date,
  city,
  pageTitle
FROM `data-to-insights.ecommerce.all_sessions_raw`
WHERE date = '20180708'
LIMIT 5
```

Before the query runs, the query engine does not know whether 2018 data exists to satisfy the WHERE clause condition and it needs to scan through all records in a non-partitioned table.


```sql
#standardSQL
SELECT *
FROM `data-to-insights.ecommerce.partition_by_day`
WHERE date_formatted = '2018-07-08'
```

The query engine knows which partitions already exist and knows that no partition exists for 2018-07-08 (the ecommerce dataset ranges from 2016-08-01 to 2017-08-01).

