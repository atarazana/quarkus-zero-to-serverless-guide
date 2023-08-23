#!/bin/sh

export BASE_IMAGE=quay.io/devfile/base-developer-image:ubi8-latest

export ARTIFACT_VERSION="1.1.0"
export ARTIFACT_ID=udi
export GIT_HASH=$(git rev-parse HEAD)

export REGISTRY=quay.io
export REGISTRY_USER_ID=atarazana
export PROJECT_ID=quarkus-zero
# export APP_NAME=${PROJECT_ID}-app

