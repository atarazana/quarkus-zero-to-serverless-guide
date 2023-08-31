#!/bin/sh

. ./image-env.sh

# USE_JAVAX="-e USE_JAVA17=true"

podman run -it --rm -p 8080:8080 --name ${PROJECT_ID}-${ARTIFACT_ID} ${USE_JAVAX} localhost/${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION} bash
