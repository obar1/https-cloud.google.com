
# <https:§§www.cloudskillsboost.google§games§2854§labs§17208>
> <https://www.cloudskillsboost.google/games/2854/labs/17208>
        
![](2022-07-05-09-25-47.png)

## Create Cloud Composer environment

![](2022-07-05-09-26-42.png)


## Airflow and core concepts
[https://airflow.apache.org/](/https:§§airflow.apache.org§/readme.md)

[https://airflow.apache.org/concepts.html](/https:§§airflow.apache.org§concepts.html/readme.md)
[https://airflow.apache.org/docs/apache-airflow/stable/concepts/index.html](/https:§§airflow.apache.org§docs§apache-airflow§stable§concepts§index.html/readme.md)

```py
"""Example Airflow DAG that creates a Cloud Dataproc cluster, runs the Hadoop
wordcount example, and deletes the cluster.
This DAG relies on three Airflow variables
[https://airflow.apache.org/concepts.html#variables](/https:§§airflow.apache.org§concepts.html#variables/readme.md)
* gcp_project - Google Cloud Project to use for the Cloud Dataproc cluster.
* gce_zone - Google Compute Engine zone where Cloud Dataproc cluster should be
  created.
* gcs_bucket - Google Cloud Storage bucket to use for result of Hadoop job.
  See https://cloud.google.com/storage/docs/creating-buckets for creating a
  bucket.
"""
import datetime
import os
from airflow import models
from airflow.contrib.operators import dataproc_operator
from airflow.utils import trigger_rule
# Output file for Cloud Dataproc job.
output_file = os.path.join(
    models.Variable.get('gcs_bucket'), 'wordcount',
    datetime.datetime.now().strftime('%Y%m%d-%H%M%S')) + os.sep
# Path to Hadoop wordcount example available on every Dataproc cluster.
WORDCOUNT_JAR = (
    'file:///usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar'
)
# Arguments to pass to Cloud Dataproc job.
wordcount_args = ['wordcount', 'gs://pub/shakespeare/rose.txt', output_file]
yesterday = datetime.datetime.combine(
    datetime.datetime.today() - datetime.timedelta(1),
    datetime.datetime.min.time())
default_dag_args = {
    # Setting start date as yesterday starts the DAG immediately when it is
    # detected in the Cloud Storage bucket.
    'start_date': yesterday,
    # To email on failure or retry set 'email' arg to your email and enable
    # emailing here.
    'email_on_failure': False,
    'email_on_retry': False,
    # If a task fails, retry it once after waiting at least 5 minutes
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=5),
    'project_id': models.Variable.get('gcp_project')
}
# [START composer_hadoop_schedule]
with models.DAG(
        'composer_hadoop_tutorial',
        # Continue to run DAG once per day
        schedule_interval=datetime.timedelta(days=1),
        default_args=default_dag_args) as dag:
    # [END composer_hadoop_schedule]
    # Create a Cloud Dataproc cluster.
    create_dataproc_cluster = dataproc_operator.DataprocClusterCreateOperator(
        task_id='create_dataproc_cluster',
        # Give the cluster a unique name by appending the date scheduled.
        # See https://airflow.apache.org/code.html#default-variables
        cluster_name='composer-hadoop-tutorial-cluster-{{ ds_nodash }}',
        num_workers=2,
        region='us-central1',
        zone=models.Variable.get('gce_zone'),
        image_version='2.0',
        master_machine_type='n1-standard-2',
        worker_machine_type='n1-standard-2')
    # Run the Hadoop wordcount example installed on the Cloud Dataproc cluster
    # master node.
    run_dataproc_hadoop = dataproc_operator.DataProcHadoopOperator(
        task_id='run_dataproc_hadoop',
        region='us-central1',
        main_jar=WORDCOUNT_JAR,
        cluster_name='composer-hadoop-tutorial-cluster-{{ ds_nodash }}',
        arguments=wordcount_args)
    # Delete Cloud Dataproc cluster.
    delete_dataproc_cluster = dataproc_operator.DataprocClusterDeleteOperator(
        task_id='delete_dataproc_cluster',
        region='us-central1',
        cluster_name='composer-hadoop-tutorial-cluster-{{ ds_nodash }}',
        # Setting trigger_rule to ALL_DONE causes the cluster to be deleted
        # even if the Dataproc job fails.
        trigger_rule=trigger_rule.TriggerRule.ALL_DONE)
    # [START composer_hadoop_steps]
    # Define DAG dependencies.
    create_dataproc_cluster >> run_dataproc_hadoop >> delete_dataproc_cluster
    # [END composer_hadoop_steps]
```

To orchestrate the three workflow tasks, the DAG imports the following operators:

DataprocClusterCreateOperator: Creates a Cloud Dataproc cluster.
DataProcHadoopOperator: Submits a Hadoop wordcount job and writes results to a Cloud Storage bucket.
DataprocClusterDeleteOperator: Deletes the cluster to avoid incurring ongoing Compute Engine charges.

![](2022-07-05-09-29-03.png)


## Setting Airflow variables

![](2022-07-05-09-29-23.png)

```
student_03_9abad570ad92@cloudshell:~ (qwiklabs-gcp-02-f7218f4bbe76)$ gsutil cp gs://cloud-training/datawarehousing/lab_assets/hadoop_tutorial.py gs://us-central1-highcpu-238d604d-bucket/dags/
```

## Exploring DAG runs

![](2022-07-05-09-31-46.png)

![](2022-07-05-09-32-58.png)

![](2022-07-05-09-33-05.png)

![](2022-07-05-09-33-57.png)

running dataproc

![](2022-07-05-09-34-37.png)



## Student Resources

videocam
Flexible, Easy Data Pipelines on Google Cloud with Cloud Compooser (NEXT'18)
[https://www.youtube.com/watch?v=GeNFEtt-D4k](/https:§§www.youtube.com§watch?v=GeNFEtt-D4k/readme.md)
