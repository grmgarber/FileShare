#!/bin/sh

LC=$(git rev-parse --short HEAD)
docker build -t grmgarber/fupl:${LC} .
docker push grmgarber/fupl:${LC}

