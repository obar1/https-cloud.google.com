#!/usr/bin/env bash
set -u
set -o pipefail
# set -e
# v0.1

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

function list_bucket() { # list bucket
    gsutil ls
    gsutil ls -r gs://"$BUCKET_ID"/**
}

### prj support

function dir_from_http() { # convert from http to valid local dir name [http_address]
    http_address="${1}"
    echo "$http_address"

    section="$(echo $http_address | sed 's/\//§/g')"
    echo "$section"
    export section
}

function make_dir_section() { # mkdir and readme [dir_from_http]
    dir_from_http "${1}"
    mkdir -p "$section"
    # `https:xxx.google.yyy`
    # 
    # > <https://xxx.google.com/yyy>

    echo "# \`${section}\`" >>"$section"/readme.md
    echo "" >>"$section"/readme.md
    echo "> <${1}>" >>"$section"/readme.md
    # cp "${BASE_PATH}"/runme.template.sh "$section"/runme.md
}

function add_section_to_map() { # add is http://  to toc and add section [dir_from_http]
    dir_from_http "${1}"
    map_rel_path="${2}"
    # 1. <https://cloud.google.com/apis/docs/cloud-client-libraries> :o: [`here`](../https:§§cloud.google.com§apis§docs§cloud-client-libraries/readme.md)
    echo "1. <${1}> :o: [\`here\`](../$section/readme.md)" >>"$map_rel_path"
    tail "$map_rel_path"
}

function sort_map() { # sort the map file
    map_rel_path="${1}"
    < "$map_rel_path" | grep -v "^$" | sort  > tmpfile && mv tmpfile "$map_rel_path"
}

function convert_pdf_to_txt() { # pdf export [dir_from_http]
    dir_from_http "${1}"
    echo mv "${section}/*.pdf ${section}/readme.pdf"
    echo pdftotext "$section"/readme.pdf "$section"/readme.pdf.txt
    echo ls -r "$section"
}

function do_section() { # main do to process a section  [http_address]
    http_address="${1}"
    make_dir_section "${http_address}"
    map_rel_path="_core/map.md"
    add_section_to_map "${http_address}" "${map_rel_path}"
    # sort_map "${map_rel_path}"
    convert_pdf_to_txt "${http_address}"
}
