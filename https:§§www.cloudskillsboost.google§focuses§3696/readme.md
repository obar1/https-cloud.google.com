
# <https:§§www.cloudskillsboost.google§focuses§3696>
> <https://www.cloudskillsboost.google/focuses/3696>
        
## intro

In traditional relational database SQL, you would look at the repetition of names and immediately think to split the above table into two separate tables: Fruit Items and People. That process is called normalization (going from one table to many). This is a common approach for transactional databases like mySQL.

![](2022-07-02-19-22-31.png)


repeated fields
![](2022-07-02-19-22-41.png)

![](2022-07-02-19-23-05.png)

```
#standardSQL
SELECT
['raspberry', 'blackberry', 'strawberry', 'cherry'] AS fruit_array
```
same type only
![](2022-07-02-19-23-55.png)

![](2022-07-02-19-24-19.png)

fruit_details
![](2022-07-02-19-25-53.png)
![](2022-07-02-19-26-07.png)

create repeated fields
![](2022-07-02-19-26-47.png)

```
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(v2ProductName) AS products_viewed,
  ARRAY_AGG(pageTitle) AS pages_viewed
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date
```
![](2022-07-02-19-27-46.png)

```
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(v2ProductName) AS products_viewed,
  ARRAY_LENGTH(ARRAY_AGG(v2ProductName)) AS num_products_viewed,
  ARRAY_AGG(pageTitle) AS pages_viewed,
  ARRAY_LENGTH(ARRAY_AGG(pageTitle)) AS num_pages_viewed
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date
```
![](2022-07-02-19-29-11.png)

```sql
-- distinct
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(DISTINCT v2ProductName) AS products_viewed,
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT v2ProductName)) AS distinct_products_viewed,
  ARRAY_AGG(DISTINCT pageTitle) AS pages_viewed,
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT pageTitle)) AS distinct_pages_viewed
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date
```

![](2022-07-02-19-30-34.png)

## dataset with arrays

![](2022-07-02-19-33-41.png)

```sql
-- un-nest
SELECT DISTINCT
  visitId,
  h.page.pageTitle
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
UNNEST(hits) AS h
WHERE visitId = 1501570398
LIMIT 10
```
![](2022-07-02-19-34-41.png)
![](2022-07-02-19-35-39.png)

You need to UNNEST() arrays to bring the array elements back into rows
UNNEST() always follows the table name in your FROM clause (think of it conceptually like a pre-joined table)

## STRUCTs
[https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types#struct-type](/https:§§cloud.google.com§bigquery§docs§reference§standard-sql§data-types#struct-type/readme.md)

![](2022-07-02-19-51-43.png)

![](2022-07-02-19-54-51.png)

![](2022-07-02-19-55-04.png)

![](2022-07-02-19-55-34.png)

![](2022-07-02-19-55-59.png)

create table
```sql
[
    {
        "name": "race",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "participants",
        "type": "RECORD",
        "mode": "REPEATED",
        "fields": [
            {
                "name": "name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "splits",
                "type": "FLOAT",
                "mode": "REPEATED"
            }
        ]
    }
]
```

![](2022-07-02-19-59-16.png)

![](2022-07-02-19-59-54.png)

![](2022-07-02-20-00-12.png)


```sql
#standardSQL
SELECT COUNT(p.name) AS racer_count
FROM racing.race_results AS r, UNNEST(r.participants) AS p
```

unnest
```sql
#standardSQL
SELECT
  p.name,
  SUM(split_times) as total_race_time
FROM racing.race_results AS r
, r.participants AS p
, p.splits AS split_times
WHERE
GROUP BY
ORDER BY
;
```