
# <https:§§www.cloudskillsboost.google§focuses§577>
> <https://www.cloudskillsboost.google/focuses/577>

## setup 
gcloud auth list
gcloud config list project

## bq
```bash
bq show bigquery-public-data:samples.shakespeare

bq help query

bq query '<SQL>'

--use_legacy_sql=false  #std sql

bq ls # existing dataset
bq ls bigquery-public-data:

bq mk babynames # mk a dataset

bq load babynams.names2010 \
yob2010.txt \
name:string,gender:string,count:integer
#create table and load file contents

bq ls babynames
bq show babynames.names2010

bq rm -r babynames # delete all ds contents
```