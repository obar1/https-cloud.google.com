#!/usr/bin/env bash

# some tools

# set -e
set -u
set -o pipefail
# set -x #verbose

# FIXME: set your BASE_PATH
BASE_PATH=/Users/mamat/git/obar1/https-cloud.google.com.com.git
export BASE_PATH

ME='tools.sh'
export ME

### INFO

function info() { # Source me to add func() to the env
    # ex # info "$BASE_PATH/$ME"
    grep 'function' "$1" | grep -v "#skip" #skip
}

function list_api() {
    # list enabled api
    gcloud services list
}

function list_bucket() {
    # list bucket
    # list_bucket || true
    gsutil ls
    gsutil ls -r gs://"$BUCKET_ID"/**
}
