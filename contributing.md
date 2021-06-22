# contrib

## adding new pages

> we want to 1 level hierarchy and avoid the deep levels of the pages
go on the https://cloud.google.com/
- get a page like https://cloud.google.com/dataflow
- convert `/ -> §` like https:§§cloud.google.com§dataflow
-  create a new folder with new name 
- (opt) save the page with https://chrome.google.com/webstore/detail/print-friendly-pdf/ohlencieiipommannpdfcmfdpjjmeolj/related or https://chrome.google.com/webstore/detail/htmlurl-to-pdf-with-pdfma/dlmgniacaacmbccdegkadebbaphkonpb 
- add the readme.md with summary/note/code samples

ex

```bash
section=https:§§cloud.google.com§dataflow

mkdir -p $section && touch $section/readme.md
ls -1
```

## committing to repo

- [X] just commit to master as this is a wiki -  `don't make it overcomplicated`
- [X] use  `wip #issue_id` 
https://github.com/obar1/https-cloud.google.com/issues
so you can see the time spent in the 
https://github.com/obar1/https-cloud.google.com/tree/main
 that took overall

> if we start to squash and merge yes the history looks better but you would loose those interesting info

- [X] use `000` as commit msg for small improvements not related to actual learning