#!/bin/sh

cd $(dirname $0)

. ../image-env.sh

MAVEN_SETTINGS_XML=$(pwd)/settings.xml
LOCAL_REPO=$(pwd)/maven-repository-${QUARKUS_VERSION}
mkdir -p ${LOCAL_REPO}

alias mvn="mvn -s ${MAVEN_SETTINGS_XML} -Dmaven.repo.local=${LOCAL_REPO}"

mvn io.quarkus:quarkus-maven-plugin:${QUARKUS_VERSION}:create \
  -DprojectGroupId=org.acme -DprojectArtifactId=footest \
  -DplatformVersion=${QUARKUS_VERSION} \
  -Dextensions="quarkus-agroal,quarkus-arc,quarkus-hibernate-orm,quarkus-hibernate-orm-panache,quarkus-jdbc-h2,quarkus-jdbc-postgresql,quarkus-kubernetes,quarkus-scheduler,quarkus-smallrye-fault-tolerance,quarkus-smallrye-health,quarkus-smallrye-opentracing,openshift" && \
rm -rf footest

mvn -f atomic-fruit-service quarkus:dev

mvn -f atomic-fruit-service clean compile package
# mvn -f atomic-fruit-service clean compile package -Pnative

mvn -f atomic-fruit-service clean package -Dquarkus.kubernetes.deploy=true -DskipTests





