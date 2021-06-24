# https:§§cloud.google.com§functions§docs§quickstart
> https://cloud.google.com/functions/docs/quickstart

## Before you begin

enable api
https://console.cloud.google.com/flows/enableapi?apiid=cloudfunctions,cloudbuild.googleapis.com&redirect=https://cloud.google.com/functions/quickstart&_ga=2.195397676.1808267204.1624474724-1468234203.1624256121

update components

```
gcloud components update
```

### Get the sample code

```
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

cd python-docs-samples/functions/helloworld/
```

in https:§§cloud.google.com§functions§docs§quickstart/helloworld/main.py

```python
# [START functions_helloworld_get]
def hello_get(request):
    """HTTP Cloud Function.
    Args:
        request (flask.Request): The request object.
        <https://flask.palletsprojects.com/en/1.1.x/api/#incoming-request-data>
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <https://flask.palletsprojects.com/en/1.1.x/api/#flask.make_response>.
    Note:
        For more information on how Flask integrates with Cloud
        Functions, see the `Writing HTTP functions` page.
        <https://cloud.google.com/functions/docs/writing/http#http_frameworks>
    """
    return 'Hello World!'
# [END functions_helloworld_get]
```

## Deploy a function

```bash
gcloud functions deploy hello_get \
--runtime python39 --trigger-http --allow-unauthenticated
```
![](2021-06-24-14-56-01.png)

## Test the function
check what to do
```
gcloud functions describe hello_get
```

https://us-central1-coherent-vim-317506.cloudfunctions.net/hello_get


Visit this URL in your browser. You should see a Hello World! message.

![](2021-06-24-14-58-31.png)

## Delete the function

```
gcloud functions delete hello_get 
```

![](2021-06-24-14-59-21.png)