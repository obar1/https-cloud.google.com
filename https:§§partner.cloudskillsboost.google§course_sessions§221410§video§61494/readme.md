# <https:§§partner.cloudskillsboost.google§course_sessions§221410§video§61494>
> <https://partner.cloudskillsboost.google/course_sessions/221410/video/61494>

## Loading Data

![](2022-03-30-14-29-20.png)
rl =  as it is
elt = loaded into table and tranformed there
etl = transf occurs in other componenet before to be loaded in bq

![](2022-03-30-14-30-06.png)
no need for Tr

![](2022-03-30-14-30-19.png)
supported files
load job created adestination table iof it does not exists
avro defined the schena automaticaly
json/csv can autodetect schema
data can be appended to tables and no schema needed to be specified
you can use CF to lunch load jons

![](2022-03-30-14-32-39.png)
bq can import data using api too
api can be used from app engine cf kubernetics
use cloud dtaflow or cloud data proc 

![](2022-03-30-14-33-53.png)
use staging table 

![](2022-03-30-14-34-12.png)
you can schedule query and cache results
use of parametrize

![](2022-03-30-14-34-51.png)
you can restored data for the last 7 days
ex as 24 hours ago

![](2022-03-30-14-35-57.png)
transfer service to import data in bq from existing onpremise
back filling data with no gaps

![](2022-03-30-14-37-33.png)
def connectors and scheduled service

![](2022-03-30-14-38-30.png)
how it works

![](2022-03-30-14-39-09.png)
don't use bq as as olap

![](2022-03-30-14-39-39.png)

![](2022-03-30-14-39-46.png)
query external table via federated query
no need to import first

![](2022-03-30-14-40-36.png)
def extrnal connection
EXTERNAL_QUERY

![](2022-03-30-14-41-32.png)
use UDF for specific function
js only supported
use sql if possible

![](2022-03-30-14-42-46.png)
persited udf 





