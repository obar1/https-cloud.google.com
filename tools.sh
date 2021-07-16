#!/usr/bin/env bash

# some tools
# FIXME: source me on the prompt

# TODO: set your BASE_PATH
BASE_PATH=/Users/mamat/git/obar1/https-cloud.google.com.com.git
export BASE_PATH

### INIT

function load_secrets() {
   source "${BASE_PATH}"/secrets/runme.sh
}

function set_region() {
   export GCP_REGION="us-central1"
   gcloud config set compute/region "$GCP_REGION"
}

### INFO

function info() { # print small help  [file]
    file="${1}"
    # grep section ## or function with #
    grep -E '##|function' "$file" | grep  "#" 
}

function list_api() { # list enabled api
    gcloud services list
}

function list_bucket() { # list bucket
    gsutil ls
    gsutil ls -r gs://"$BUCKET_ID"/**
}

### fs
function dir_from_http() { # convert from http to valid local dir name [http_address]
    http_address="${1}"
    echo "$http_address"

    section="$(echo $http_address | sed 's/\//§/g')"
    echo "$section"
    export section
}

function make_dir_section() { # mkdir and readme [dir_from_http]
    dir_from_http "${1}"
    mkdir -p "$section" && touch "$section"/readme.md
    echo "# ""$section" >>"$section"/readme.md
    echo "> $1" >>"$section"/readme.md
    cat "$section"/readme.md

    cat runme.template.sh >"$section"/runme.md
}

function add_section_to_changelog(){  # add is http://  to toc and add section [dir_from_http]
    dir_from_http "${1}"
    echo "- [ ] ${1}   [here](./$section/readme.md)" >> changelog.md
    cat changelog.md
}

function convert_pdf_to_txt() { # pdf export [dir_from_http]
    dir_from_http "${1}"
    mv "${section}/*.pdf ${section}/readme.pdf"
    pdftotext "$section"/readme.pdf "$section"/readme.pdf.txt
    ls -r "$section"
}

function do_section() { # main do to process a section  [http_address]
    http_address="${1}"
    make_dir_section "${http_address}"
    add_section_to_changelog "${http_address}"

    echo -n "convert_pdf_to_txt (y/n)? "
    read -r answer

    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo Yes
        convert_pdf_to_txt "${http_address}"
    else
        echo No
    fi
}


load_secrets
set_region