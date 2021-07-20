# https:§§cloud.google.com§api-gateway§docs§creating-api
> https://cloud.google.com/api-gateway/docs/creating-api

> deploy cf
[`here`](../https:§§cloud.google.com§functions§docs§quickstart/readme.md)

## API ID requirements

create the api
```
gcloud api-gateway apis create API_ID  
```

describe the api
```
gcloud api-gateway apis describe API_ID  
```

> gcloud options
--async
--display-name=NAME
--labels

## Listing APIs
```
gcloud api-gateway apis list --project=PROJECT_ID
```

## Updating an API

you can update
- display-name
- labels

## delete api

delete each api config associated with api
```
gcloud api-gateway api-configs delete CONFIG_ID --api=API_ID --project=PROJECT_ID
```

delete api
```
gcloud api-gateway apis delete API_ID --project=PROJECT_ID
```

## What's next

[`here`](../https:§§cloud.google.com§api-gateway§docs§creating-api-config/readme.md)