# https:§§cloud.google.com§api-gateway§docs§authenticate-service-account
> https://cloud.google.com/api-gateway/docs/authenticate-service-account

authenticate services - not only humans -  for api req

## Overview

to identify a service that sends req to  api use sa
the calling service uses sa private key to sign a secure json web token 
https://jwt.io/
and sends signed req to the api

1. create sa and key for the calling service to use
2. add auth in api config gateway service
3. add code to  the calling service
    - creates a jwt and sings it with sa private key
    - send a signed jwt in api req (header)

api gateway validates the claim before fwd the req to the actual api
> api gateway does not check for cloud identity

## Prerequisites

https://cloud.google.com/api-gateway/docs/openapi-overview :ok:

https://cloud.google.com/api-gateway/docs/creating-api-config

## Creating a service account with a key
