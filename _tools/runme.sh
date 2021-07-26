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
    echo "# ""$section" >>"$section"/readme.md
    echo "> $1" >>"$section"/readme.md
    # cp "${BASE_PATH}"/runme.template.sh "$section"/runme.md
}

function add_section_to_changelog() { # add is http://  to toc and add section [dir_from_http]
    dir_from_http "${1}"
    core_folder='_core'
    core_changelog='changelog.md'
    echo "- ${1} :o: [\`here\`](../$section/readme.md)" >>"$core_folder/$core_changelog"
    tail "$core_folder/$core_changelog"
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
    add_section_to_changelog "${http_address}"
    convert_pdf_to_txt "${http_address}"
}
