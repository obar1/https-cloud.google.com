#!/usr/bin/env bash
###################
# some tools
#################

### INFO

function info() { # print small help  [file]
    file="${1}"
    # grep section ## or function with #
    grep -E '##|function' "$file" | grep "#"
}

## API

function list_api() { # list enabled api
    gcloud services list
}
 