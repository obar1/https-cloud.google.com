#!/usr/bin/env python
# v 0.1
"""Section."""

from google.cloud import bigquery
from numpy import empty
from google.cloud.bigquery.job.query import QueryJob


class Config:
    def __init__(self, GCP_PROJECT: str, GOOGLE_APPLICATION_CREDENTIALS: str):
        self.GCP_PROJECT = GCP_PROJECT
        self.GOOGLE_APPLICATION_CREDENTIALS = GOOGLE_APPLICATION_CREDENTIALS

    def __repr__(self) -> str:
        return (self.GCP_PROJECT + self.GOOGLE_APPLICATION_CREDENTIALS)


def before_you_begin():
    import os
    config = Config(os.getenv("GCP_PROJECT"),  os.getenv(
        "GOOGLE_APPLICATION_CREDENTIALS"))
    assert config.GCP_PROJECT is not empty
    assert config.GOOGLE_APPLICATION_CREDENTIALS is not empty
    print(config)
    return config


def running_query(client: bigquery.Client, query: str) -> QueryJob:
    return client.query(query)


def run_me():
    config = before_you_begin()

    client = bigquery.Client()

    query = """
    SELECT
        CONCAT(
        'https://stackoverflow.com/questions/',
        CAST(id as STRING)) as url,
        view_count
    FROM `bigquery-public-data.stackoverflow.posts_questions`
    WHERE tags like '%google-bigquery%'
    ORDER BY view_count DESC
    LIMIT 10
    """

    query_job = running_query(client, query)

    results = query_job.result()  # Waits for job to complete.

    for row in results:
        print("{} : {} views".format(row.url, row.view_count))


if __name__ == "__main__":
    run_me()
