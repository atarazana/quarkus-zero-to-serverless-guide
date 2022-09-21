#!/bin/sh

. ./image-env.sh

./create-maven-repository/run.sh

podman build -t $IMAGE_NAME:$IMAGE_VERSION --build-arg FROM_IMAGE=${FROM_IMAGE} --build-arg QUARKUS_VERSION=${QUARKUS_VERSION} .