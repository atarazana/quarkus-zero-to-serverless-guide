# To build this stack:
# docker build -t quay.io/username/quarkus-workshop-stack:VVV -f stack.Dockerfile .
# docker push quay.io/username/quarkus-workshop-stack:VVVV

ARG FROM_IMAGE
FROM ${FROM_IMAGE} AS BASE

#ENV MANDREL_VERSION=21.0.0.0.Final
ENV MANDREL_VERSION=20.3.1.2-Final

ENV KN_VERSION=0.19.1
ENV TKN_VERSION=0.15.0
ENV OC_VERSION=4.6
ENV GRAALVM_HOME="/usr/local/mandrel-java11-${MANDREL_VERSION}"
ENV PATH="/usr/local/maven/apache-maven-${MVN_VERSION}/bin:${PATH}"

USER root

RUN wget -O /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable-${OC_VERSION}/openshift-client-linux.tar.gz && cd /usr/bin && tar -xvzf /tmp/oc.tar.gz && chmod a+x /usr/bin/oc && chmod a+x /usr/bin/kubectl && rm -f /tmp/oc.tar.gz

RUN wget -O /tmp/kn.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/serverless/${KN_VERSION}/kn-linux-amd64-${KN_VERSION}.tar.gz && cd /usr/bin && tar -xvzf /tmp/kn.tar.gz ./kn && chmod a+x kn && rm -f /tmp/kn.tar.gz

RUN wget -O /tmp/tkn.tar.gz https://github.com/tektoncd/cli/releases/download/v${TKN_VERSION}/tkn_${TKN_VERSION}_Linux_x86_64.tar.gz && cd /usr/bin && tar -xvzf /tmp/tkn.tar.gz tkn&& chmod a+x tkn && rm -f /tmp/tkn.tar.gz

RUN sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && sudo microdnf install -y zlib-devel gcc siege && sudo curl -Lo /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && sudo chmod a+x /usr/bin/jq

RUN wget -O /tmp/mandrel.tar.gz https://github.com/graalvm/mandrel/releases/download/mandrel-${MANDREL_VERSION}/mandrel-java11-linux-amd64-${MANDREL_VERSION}.tar.gz && cd /usr/local && tar -xvzf /tmp/mandrel.tar.gz && rm -rf /tmp/mandrel.tar.gz

USER jboss

FROM BASE

#ENV QUARKUS_VERSION=1.13.2.Final
ENV QUARKUS_VERSION=1.11.6.Final-redhat-00001

USER jboss

RUN mkdir /home/jboss/.m2

COPY settings.xml /home/jboss/.m2

RUN cd /tmp && mkdir project && cd project && mvn io.quarkus:quarkus-maven-plugin:${QUARKUS_VERSION}:create -DprojectGroupId=org.acme -DprojectArtifactId=footest -DplatformVersion=${QUARKUS_VERSION} -Dextensions="quarkus-agroal,quarkus-arc,quarkus-hibernate-orm,quarkus-hibernate-orm-panache,quarkus-jdbc-h2,quarkus-jdbc-postgresql,quarkus-kubernetes,quarkus-scheduler,quarkus-smallrye-fault-tolerance,quarkus-smallrye-health,quarkus-smallrye-opentracing" && mvn -f footest clean compile package && cd / && rm -rf /tmp/project

RUN cd /tmp && mkdir project && cd project && mvn io.quarkus:quarkus-maven-plugin:${QUARKUS_VERSION}:create -DprojectGroupId=org.acme -DprojectArtifactId=footest -DplatformVersion=${QUARKUS_VERSION} -Dextensions="quarkus-smallrye-reactive-streams-operators,quarkus-smallrye-reactive-messaging,quarkus-smallrye-reactive-messaging-kafka,quarkus-swagger-ui,quarkus-vertx,quarkus-kafka-client, quarkus-smallrye-metrics,quarkus-smallrye-openapi,quarkus-qute,quarkus-resteasy-qute" && mvn -f footest clean compile package -Pnative && cd / && rm -rf /tmp/project

RUN rm -rf /tmp/quarkus /tmp/vertx-cache /tmp/hsperfdata_jboss

#RUN cd /tmp && git clone https://github.com/RedHat-Middleware-Workshops/quarkus-workshop-m3-labs && cd quarkus-workshop-m3-labs && git checkout ocp-${OC_VERSION} && for proj in *-petclinic* ; do mvn -fn -f ./$proj dependency:resolve-plugins dependency:resolve dependency:go-offline clean compile -DskipTests ; done && cd /tmp && rm -rf /tmp/quarkus-workshop-m3-labs

#RUN siege && sed -i 's/^connection = close/connection = keep-alive/' $HOME/.siege/siege.conf && sed -i 's/^benchmark = false/benchmark = true/' $HOME/.siege/siege.conf

RUN echo '-w "\n"' > $HOME/.curlrc

USER root

RUN chown -R jboss /home/jboss/.m2
RUN chmod -R a+w /home/jboss/.m2
#RUN chmod -R a+rwx /home/jboss/.siege
USER jboss
