#!/bin/sh

. ./image-env.sh

podman tag ${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH} $REGISTRY/$REGISTRY_USER_ID/${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH}
podman tag ${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH} $REGISTRY/$REGISTRY_USER_ID/${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION}

podman push $REGISTRY/$REGISTRY_USER_ID/${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH}
podman push $REGISTRY/$REGISTRY_USER_ID/${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION}
