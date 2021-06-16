
# <https:§§www.cloudskillsboost.google§focuses§3694>
> <https://www.cloudskillsboost.google/focuses/3694>

## partitioned tables
have partition to save time and cost

```sql
create or replace table ecommerce.partition_by_day 
partition by date_formatted
options(description="part ecommerce") as
select distinct 
parse_date("%Y%m%d",date) as date_formatted,
fullvisitorId 
FROM`data-to-insights.ecommerce.all_sessions_raw`
```

```sql
SELECT DATE(CAST(year AS INT64), CAST(mo AS INT64), CAST(da AS INT64)) AS date, 
(SELECT ANY_VALUE(name) FROM `bigquery-public-data.noaa_gsod.stations` AS stations WHERE stations.usaf = stn) AS station_name, --Stations may have multiple names prcp 
FROM `bigquery-public-data.noaa_gsod.gsod*`AS weather WHERE prcp < 99.9 -- Filter unknown values 
AND prcp > 0 -- Filterstations/days with no precipitation 
AND _TABLE_SUFFIX >= '2018' 
ORDER BY date DESC -- Where has it rained/snowed recently LIMIT 
```

ANY_VALUE
_TABLE_SUFFIX

use of expiration
```sql
CREATE OR REPLACE TABLE ecommerce.days_with_rain 
PARTITION BY date 
OPTIONS ( partition_expiration_days=60, description="weather stations withprecipitation, partitioned by day" ) AS
```

