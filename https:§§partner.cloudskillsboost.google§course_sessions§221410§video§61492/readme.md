# <https:§§partner.cloudskillsboost.google§course_sessions§221410§video§61492>
> <https://partner.cloudskillsboost.google/course_sessions/221410/video/61492>
        
## Demo:Querying TB of Data in seconds

![](2022-03-28-18-21-45.png)

[https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/courses/data-engineering/demos/bigquery_scale.md](/https:§§github.com§GoogleCloudPlatform§training-data-analyst§blob§master§courses§data-engineering§demos§bigquery_scale.md/readme.md)

```sql
SELECT
  language,
  title,
  SUM(views) AS views
FROM
  `bigquery-samples.wikipedia_benchmark.Wiki100B`
WHERE
  UPPER(title) LIKE '%GOOG%'
GROUP BY
  language,
  title
ORDER BY
  views DESC;
```

![](2022-03-28-18-26-18.png)

use cmd click to show table info 
shortcuts

![](2022-03-28-18-28-47.png)

```sql
SELECT
hour,
AVG(fare) AS avg_fare
FROM (
  SELECT
  EXTRACT(HOUR
  FROM
  trip_start_timestamp) AS hour,
  fare
  FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips` 
  WHERE pickup_community_area = 32
)
GROUP BY hour
ORDER BY avg_fare DESC
```

no idx needed to be managed

resources
![](2022-03-28-18-32-44.png)

stages
![](2022-03-28-18-33-24.png)
