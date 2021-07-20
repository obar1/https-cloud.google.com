# https:§§cloud.google.com§api-gateway§docs§authentication-method
> https://cloud.google.com/api-gateway/docs/authentication-method

api gateway supports multiple auth methods
it's defined in the service configuration 

## API keys

api key is simple string that identifies a prj
developer generates api key and embed that key in every call as query parameter or in the request header

it's not credentials 
> man in the middle attack

## About API key authentication for API Gateway

enable api key support for your service

```
cloud services enable API_ID-HASH.apigateway.PROJECT_ID.cloud.goog
#For example:
gcloud services enable my-api-a12bcd345e67f89g0h.apigateway.my-project.cloud.goog
```

## Service accounts

to identify a service that sends req to the api  use service account
https://cloud.google.com/docs/authentication#service_accounts
calling service use service account private key  to sign in json web token
https://jwt.io/ and send signed jwt in the req to  the api

## Use case
[`here`](../https:§§cloud.google.com§api-gateway§docs§authenticate-service-account/readme.md)
