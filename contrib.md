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
mkdir -p $section & touch $section/readme.md
ls -1
```