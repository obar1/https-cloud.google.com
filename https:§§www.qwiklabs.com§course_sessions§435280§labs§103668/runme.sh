#!/usr/bin/env bash
set -u
set -o pipefail
set +x

source ../0to100-latest/scripts/init.sh
source ../0to100-latest/scripts/tools.sh


function Setting_up_virtual_environment_and_dependencies() {
    # Next, install the packages you will need to execute your pipeline:
    python3 -m pip install -q --upgrade pip setuptools wheel
    python3 -m pip install 'apache-beam[gcp]==2.28.0'
    
    gcloud services enable dataflow.googleapis.com
}

## Creating a service account with a key

_init_sa() {  # mng sa
    # add  for buckets
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${SA_EMAIL} --role 'roles/storage.objectCreator'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${SA_EMAIL} --role 'roles/storage.objectViewer'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${SA_EMAIL} --role 'roles/dataflow.developer'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${SA_EMAIL} --role 'roles/bigquery.jobUser'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${SA_EMAIL} --role 'roles/bigquery.dataEditor'

    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${CE_SA_EMAIL} --role 'roles/dataflow.developer'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${CE_SA_EMAIL} --role 'roles/bigquery.jobUser'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${CE_SA_EMAIL} --role 'roles/storage.objectCreator'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${CE_SA_EMAIL} --role 'roles/storage.objectViewer'
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:${CE_SA_EMAIL} --role 'roles/bigquery.dataEditor'
    #    https://cloud.google.com/iam/docs/service-accounts
    gsutil acl ch -u ${SA_EMAIL}:OWNER "gs://${PROJECT_ID}"
    gsutil acl ch -u ${CE_SA_EMAIL}:OWNER "gs://${PROJECT_ID}"
    
}


function Labpart1_WritinganETLpipelinefromscratch(){
    
    function Task_1_Generate_synthetic_data() { # prepare the gs stuff
        echo "## Task 1: Generate synthetic data"
        
        cd $BASE_DIR/../..
        
        # Create GCS buckets and BQ datasetsource
        bash create_batch_sinks.sh
        # Run a script to generate a batch of web server log events
        bash generate_batch_events.sh
        cd -
    }
    
    function Task_3_Run_your_pipeline_to_verify_that_it_works { #
        echo '## Task 3: Run your pipeline to verify that it works'
        
        cd $BASE_DIR
        
        # Run the pipelinepython3 my_pip
        
        # local
        python3 my_pipeline.py --project=${PROJECT_ID} --region=us-central1  --runner=DirectRunner
        # on gcp
        # python3 my_pipeline.py --project=${PROJECT_ID} --region=us-central1  --runner=DataflowRunner
        cd -
    }
    
    function Task_5_Writing_to_a_sink(){
        gsutil cat  gs://$PROJECT_ID/out/events.json-00000-of-00001 | head
    }
    
    echo "## Lab part 1: Writing an ETL pipeline from scratch"
    cd src/dataflow_python/1_Basic_ETL/lab
    export BASE_DIR=$(pwd)
    # Task_1_Generate_synthetic_data
    Task_3_Run_your_pipeline_to_verify_that_it_works
    
    # Task_5_Writing_to_a_sink
    cd -
}


function Labpart2_ParameterizingbasicETL(){
    echo "Labpart2_ParameterizingbasicETL"
}

# Setting_up_virtual_environment_and_dependencies
_init_sa
set -x
Labpart1_WritinganETLpipelinefromscratch