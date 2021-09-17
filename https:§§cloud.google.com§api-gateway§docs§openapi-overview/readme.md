# https:§§cloud.google.com§api-gateway§docs§openapi-overview
> https://cloud.google.com/api-gateway/docs/openapi-overview

[https://swagger.io/docs/specification/2-0/basic-structure/](/https:§§swagger.io§docs§specification§2-0§basic-structure§/readme.md)


ex
```yaml
    swagger: "2.0"
    info:
      title: API_ID optional-string
      description: "Get the name of an airport from its three-letter IATA code."
      version: "1.0.0"
    host: DNS_NAME_OF_DEPLOYED_API
    schemes:
      - "https"
    paths:
      "/airportName":
        get:
          description: "Get the airport name for a given IATA code."
          operationId: "airportName"
          parameters:
            -
              name: iataCode
              in: query
              required: true
              type: string
          responses:
            200:
              description: "Success."
              schema:
                type: string
            400:
              description: "The IATA code is invalid or missing."
```

collection 
[https://apis.guru/awesome-openapi3/](/https:§§apis.guru§awesome-openapi3§/readme.md)

