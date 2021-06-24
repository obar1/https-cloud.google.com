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

### fs
function dir_from_http() {
    # convert from
    # https://cloud.google.com/functions
    # to
    # https:§§cloud.google.com§functions

    http_address="${1}"
    echo "$http_address"

    section="$(echo $http_address | sed 's/\//§/g')"
    echo "$section"
    export section
}

function make_dir_section() {
    # mkdir and readme
    dir_from_http "${1}"
    mkdir -p "$section" && touch "$section"/readme.md
    echo "# ""$section" >>"$section"/readme.md
    echo "> $1" >>"$section"/readme.md
    cat "$section"/readme.md
}

function add_section_to_changelog(){
    # input is http:// add to toc and add section
    dir_from_http "${1}"
    echo "- [ ] ${1}   [here](./$section/readme.md)" >> changelog.md
    cat changelog.md
}

function convert_pdf_to_txt() {
    # opt if you exported the http  contents to ped and put in section
    dir_from_http "${1}"
    pdftotext "$section"/readme.pdf "$section"/readme.pdf.txt
    ls -r "$section"
}

function do_section() {
    # main do to process a section
    http_address="${1}"
    make_dir_section "${http_address}"
    add_section_to_changelog "${http_address}"

    echo -n "convert_pdf_to_txt (y/n)? "
    read answer

    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo Yes
        convert_pdf_to_txt "${http_address}"
    else
        echo No
    fi
}