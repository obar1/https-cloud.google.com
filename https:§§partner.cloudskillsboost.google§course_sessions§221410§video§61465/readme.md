
# <https:§§partner.cloudskillsboost.google§course_sessions§221410§video§61465>
> <https://partner.cloudskillsboost.google/course_sessions/221410/video/61465>
        
## Explore the role of a data engineer
       
![](2022-03-11-15-49-06.png)
build data pipelines on gcp
what you enable in the org writing proper pipelines
check reference architecture

![](2022-03-11-15-50-32.png)
build pipelien to dashboard 
where data driven decision can be taken
need to tranform raw data into usable ones

![](2022-03-11-15-51-25.png)
data from diff places and store raw data in datalake
ex 
gcs bucket

![](2022-03-11-15-52-06.png)
handle all the types of data
elastically scale on demand
support high throughout ingestion
fine grained access control to the objects
easy to connect to access to data
datalake = data accessable for anlytics

![](2022-03-11-15-53-42.png)
gcs for archival and storage
```
gsutil mb gs://uniq-name
```

![](2022-03-11-15-54-49.png)
transfor the data from org form in batch
use dataproc ot dataflow

![](2022-03-11-15-55-19.png)
in case of streaming
use of pub/sub dataflow and bq



