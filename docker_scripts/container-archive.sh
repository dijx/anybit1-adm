#!/bin/bash

container=$1
suffix=$(date +%Y%m%d_%H%m%S)

docker stop $container
docker container rename "$container" "${container}-${suffix}"
