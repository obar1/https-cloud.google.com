
# <https:§§www.cloudskillsboost.google§games§2854§labs§17206>
> <https://www.cloudskillsboost.google/games/2854/labs/17206>
        
What you'll learn
Loading data into BigQuery from various sources

Loading data into BigQuery using the CLI and Console

Using DDL to create tables


## Ingest a new Dataset from a CSV

Download a subset of the NYC taxi 2018 trips data locally onto your computer from here :
[https://storage.googleapis.com/cloud-training/OCBL013/nyc_tlc_yellow_trips_2018_subset_1.csv](/https:§§storage.googleapis.com§cloud-training§OCBL013§nyc_tlc_yellow_trips_2018_subset_1.csv/readme.md)

```
#standardSQL
SELECT
  *
FROM
  nyctaxi.2018trips
ORDER BY
  fare_amount DESC
LIMIT  5
```

## Ingest a new Dataset from Google Cloud Storage

```
bq load \
--source_format=CSV \
--autodetect \
--noreplace  \
nyctaxi.2018trips \
gs://cloud-training/OCBL013/nyc_tlc_yellow_trips_2018_subset_2.csv
```

## Create tables from other tables with DDL

```
#standardSQL
CREATE TABLE
  nyctaxi.january_trips AS
SELECT
  *
FROM
  nyctaxi.2018trips
WHERE
  EXTRACT(Month
  FROM
    pickup_datetime)=1;
```

```
#standardSQL
SELECT
  *
FROM
  nyctaxi.january_trips
ORDER BY
  trip_distance DESC
LIMIT
  1
```