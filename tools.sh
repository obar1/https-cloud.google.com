#!/usr/bin/env bash

# some tools

set -eu # to fail and exit on variables mathcing // safe
# set -x #verbose 

BASE_PATH=/Users/mamat/git/obar1/https-cloud.google.com.com.git
# FIXME: set your BASE_PATH
ME='tools.sh'

function info() { # Source me to add func() to the env
    grep 'function' "$1" | grep -v "#skip" #skip
}

function hello() { # hello
    echo  'hello from obar1'
}

### INFO

info "$BASE_PATH/$ME"
