[![ci](https://github.com/exam-rncp/orders/actions/workflows/main.yaml/badge.svg)](https://github.com/exam-rncp/orders/actions/workflows/main.yaml)
[![Coverage Status](https://coveralls.io/repos/github/exam-rncp/orders/badge.svg?branch=main)](https://coveralls.io/github/exam-rncp/orders?branch=main)

# DEPRECATED: orders
A microservices-demo service that provides ordering capabilities.

This build is built, tested and released by travis.

# API Spec

Checkout the API Spec [here](http://microservices-demo.github.io/api/index?url=https://raw.githubusercontent.com/microservices-demo/orders/master/api-spec/orders.json)

# Build

## Jar
`mvn -DskipTests package`

## Docker
`GROUP=weaveworksdemos COMMIT=test ./scripts/build.sh`

# Test
`./test/test.sh < python testing file >`. For example: `./test/test.sh unit.py`

# Run
`mvn spring-boot:run`

# Use
`curl http://localhost:8082`

# Push
`GROUP=weaveworksdemos COMMIT=test ./scripts/push.sh`
