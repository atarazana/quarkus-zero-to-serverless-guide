#!/bin/sh

# ENV QUARKUS_VERSION=1.13.2.Final
# ENV QUARKUS_VERSION=1.11.6.Final-redhat-00001
export QUARKUS_VERSION=1.11.7.Final-redhat-00009
export REGISTRY=quay.io
export REGISTRY_USER_ID=atarazana
export IMAGE_NAME=quarkus-stack
export IMAGE_VERSION=2.15-11
export FROM_IMAGE=registry.redhat.io/codeready-workspaces/plugin-java11-rhel8:2.15-11