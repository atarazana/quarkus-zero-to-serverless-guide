#!/bin/sh

. ./image-env.sh

podman run -u 1234 -it --rm --name quarkus-stack --entrypoint bash localhost/$IMAGE_NAME:$IMAGE_VERSION