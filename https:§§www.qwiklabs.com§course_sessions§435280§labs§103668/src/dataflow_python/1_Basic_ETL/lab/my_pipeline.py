import argparse
import time
import logging
import json
import apache_beam as beam
from apache_beam.options.pipeline_options import GoogleCloudOptions
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import StandardOptions
from apache_beam.runners import DataflowRunner, DirectRunner

# ### main


def json_load(line):
  return json.loads(line)

def get_schema():

     # Table schema for BigQuery
    return {
        "fields": [
            {
                "name": "ip",
                "type": "STRING"
            },
            {
                "name": "user_id",
                "type": "STRING"
            },
            {
                "name": "lat",
                "type": "FLOAT"
            },
            {
                "name": "lng",
                "type": "FLOAT"
            },
            {
                "name": "timestamp",
                "type": "STRING"
            },
            {
                "name": "http_request",
                "type": "STRING"
            },
            {
                "name": "http_response",
                "type": "INTEGER"
            },
            {
                "name": "num_bytes",
                "type": "INTEGER"
            },
            {
                "name": "user_agent",
                "type": "STRING"
            }
        ]
    }

def run():
    logging.getLogger().setLevel(logging.INFO)
    logging.info("Building pipeline ...")

    # Command line arguments
    parser = argparse.ArgumentParser(description='Load from Json into BigQuery')
    parser.add_argument('--project',required=True, help='Specify Google Cloud project')
    parser.add_argument('--region', required=True, help='Specify Google Cloud region')
    parser.add_argument('--runner', required=True, help='Specify Apache Beam Runner')


    opts = parser.parse_args()
    _storage_fs='gs://'
    # Setting up the Beam pipeline options
    options : PipelineOptions = PipelineOptions()
    options.view_as(GoogleCloudOptions).project = opts.project
    options.view_as(GoogleCloudOptions).region = opts.region
    options.view_as(GoogleCloudOptions).staging_location = '{0}{1}{2}'.format(_storage_fs,opts.project,'/staging/')
    options.view_as(GoogleCloudOptions).temp_location = '{0}{1}{2}'.format(_storage_fs,opts.project,'/temp/')
    options.view_as(GoogleCloudOptions).job_name = '{0}{1}'.format('my-pipeline-',time.time_ns())
    options.view_as(StandardOptions).runner = opts.runner


    # Static input and output
    input = '{1}{0}/events.json'.format(opts.project, _storage_fs)
    logging.info(input)
    output_gcs = '{1}{0}/out/events.json'.format(opts.project, _storage_fs)
    output_bq = '{0}:{1}.{2}'.format(opts.project,'logs','events')
    logging.info(output_bq)
    
    ## Task 5: Writing to a sink // GCS
    # p = beam.Pipeline(options=options)
    # (p
    #     | 'ReadFromGCS' >> beam.io.ReadFromText(input)
    #     | 'ParseJson' >> beam.Map(json_load)
    #     | 'SaveToGCS' >> beam.io.WriteToText(output_gcs)
    # )
    # p.run()

    ## Task 5: Writing to a sink //BQ
    p = beam.Pipeline(options=options)
    (p
        | 'ReadFromGCS' >> beam.io.ReadFromText(input)
        | 'ParseJson' >> beam.Map(json_load)
        | 'SaveToBQ' >> beam.io.WriteToBigQuery(
            table=output_bq,
            schema=get_schema(),
            create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED, 
            write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE)
    )
    p.run()


if __name__ == '__main__':
    get_schema()
    run()
