
#!/bin/sh

. ./image-env.sh

podman build --build-arg BASE_IMAGE=${BASE_IMAGE} -f Containerfile -t ${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH} .

podman tag ${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH} ${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION}
