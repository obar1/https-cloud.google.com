# <https:§§partner.cloudskillsboost.google§course_sessions§221410§video§61484>
> <https://partner.cloudskillsboost.google/course_sessions/221410/video/61484>

![](2022-03-24-06-22-51.png)
cl storage not for frequesnt updates
for unstructered data analytis use big table

![](2022-03-24-06-23-35.png)
oltp =  transactions/atomic/write
olap =  report/aggregated/read

![](2022-03-24-06-24-55.png)
operational sys =  freq data changes
refrsh process = grab data 
olap =  read focused
data eng build pipelines

![](2022-03-24-06-26-37.png)
el = extract dat from oltp and load in bq

stage data in gs to stage data
load from gs to bq then

![](2022-03-24-06-27-40.png)
query data from bq using federated queries
data stay in gs and not loaded in bq internal storage

