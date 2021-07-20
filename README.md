# contrib

## adding new sections

> we want to 1 level hierarchy and avoid the deep levels of the pages

- go to the https://cloud.google.com/

- get a section/link 

```
ex
https://cloud.google.com/storage
```

- create local folder and some placeholder for the section/link automatically 

```bash
source tools.sh
info tools.sh
```


ex
```
(py37) √ https-cloud.google.com.com.git % source tools.sh
(py37) √ https-cloud.google.com.com.git % info tools.sh
function info() { # print small help  [file]
function list_api() { # list enabled api
function list_bucket() { # list bucket
function dir_from_http() { # convert from http to valid local dir name [http_address]
function make_dir_section() { # mkdir and readme [dir_from_http]
function add_section_to_changelog(){  # add is http://  to toc and add section [dir_from_http]
function convert_pdf_to_txt() { # pdf export [dir_from_http]
function do_section() { # main do to process a section  [http_address]
```
ex
for https://cloud.google.com/storage
```

```

- (opt) save the page with https://chrome.google.com/webstore/detail/print-friendly-pdf/ohlencieiipommannpdfcmfdpjjmeolj/related or https://chrome.google.com/webstore/detail/htmlurl-to-pdf-with-pdfma/dlmgniacaacmbccdegkadebbaphkonpb 
- add the readme.md with summary/note/code samples


## committing to repo

- [X] just commit to master as this is a wiki -  `don't make it overcomplicated`
- [X] use  `wip #issue_id` 
https://github.com/obar1/https-cloud.google.com/issues
so you can see the time spent in the 
https://github.com/obar1/https-cloud.google.com/tree/main
 that took overall

> if we start to squash and merge yes the history looks better but you would loose those interesting info

- [X] use `000` as commit msg for small improvements not related to actual learning


## local setup - mac

> something to install


```
brew install xpdf
```
