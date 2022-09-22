# To build this stack:
# docker build -t quay.io/username/quarkus-workshop-stack:VVV -f stack.Dockerfile .
# docker push quay.io/username/quarkus-workshop-stack:VVVV

ARG FROM_IMAGE
FROM ${FROM_IMAGE} AS BASE

#ENV MANDREL_VERSION=21.0.0.0.Final
ENV MANDREL_VERSION=20.3.1.2-Final

ENV KN_VERSION=1.3.1
ENV TKN_VERSION=0.24.0
ENV OC_VERSION=4.10
ENV GRAALVM_HOME="/usr/local/mandrel-java11-${MANDREL_VERSION}"
ENV PATH="/usr/local/maven/apache-maven-${MVN_VERSION}/bin:${PATH}"

USER root

RUN wget -O /tmp/oc.tar.gz  https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable-${OC_VERSION}/openshift-client-linux.tar.gz && \
  cd /usr/bin && tar -xvzf /tmp/oc.tar.gz && \
  chmod a+x /usr/bin/oc && chmod a+x /usr/bin/kubectl && \
  rm -f /tmp/oc.tar.gz

RUN wget -O /usr/bin/kn-linux-amd64 https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/serverless/${KN_VERSION}/kn-linux-amd64 && \
  mv /usr/bin/kn-linux-amd64 /usr/bin/kn && chmod a+x /usr/bin/kn

RUN wget -O /tmp/tkn.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/pipeline/${TKN_VERSION}/tkn-linux-amd64.tar.gz && \
  cd /usr/bin && tar --no-same-owner -xvzf /tmp/tkn.tar.gz tkn && \
  rm -f /tmp/tkn.tar.gz

RUN sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
  sudo microdnf install -y zlib-devel gcc siege && \
  sudo curl -Lo /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
  sudo chmod a+x /usr/bin/jq

RUN wget -O /tmp/mandrel.tar.gz https://github.com/graalvm/mandrel/releases/download/mandrel-${MANDREL_VERSION}/mandrel-java11-linux-amd64-${MANDREL_VERSION}.tar.gz && \
  cd /usr/local && tar -xvzf /tmp/mandrel.tar.gz && \
  rm -rf /tmp/mandrel.tar.gz

USER jboss


FROM BASE
ARG QUARKUS_VERSION

ENV QUARKUS_VERSION=${QUARKUS_VERSION}
ENV QUARKUS_REPOSITORY_EXPLODED="create-maven-repository/maven-repository-${QUARKUS_VERSION}"

USER jboss

ENV MAVEN_REPO_BASE /tmp/m2
ENV MAVEN_REPO ${MAVEN_REPO_BASE}/repository
ENV MAVEN_SETTINGS_XML ${MAVEN_REPO_BASE}/settings.xml

RUN echo "MAVEN_REPO_BASE=${MAVEN_REPO_BASE}" >> ~/.bashrc && \
  echo "MAVEN_SETTINGS_XML=${MAVEN_SETTINGS_XML}" >> ~/.bashrc && \
  echo 'alias mvn="mvn -s ${MAVEN_SETTINGS_XML} -Dmaven.repo.local=${MAVEN_REPO}"' >> ~/.bashrc

# COPY external libs
RUN mkdir -p ${MAVEN_REPO_BASE}
COPY ./settings.xml /tmp/m2/

COPY ./${QUARKUS_REPOSITORY_EXPLODED} ${MAVEN_REPO}

RUN rm -rf /tmp/quarkus /tmp/vertx-cache /tmp/hsperfdata_jboss

#RUN cd /tmp && git clone https://github.com/RedHat-Middleware-Workshops/quarkus-workshop-m3-labs && cd quarkus-workshop-m3-labs && git checkout ocp-${OC_VERSION} && for proj in *-petclinic* ; do mvn -fn -f ./$proj dependency:resolve-plugins dependency:resolve dependency:go-offline clean compile -DskipTests ; done && cd /tmp && rm -rf /tmp/quarkus-workshop-m3-labs

#RUN siege && sed -i 's/^connection = close/connection = keep-alive/' $HOME/.siege/siege.conf && sed -i 's/^benchmark = false/benchmark = true/' $HOME/.siege/siege.conf

RUN echo '-w "\n"' > $HOME/.curlrc

USER root

RUN chown -R jboss /tmp/m2
RUN chmod -R a+w /tmp/m2
# RUN ls -ltrh /home/jboss/.m2 && cat /home/jboss/.m2/settings.xml
#RUN chmod -R a+rwx /home/jboss/.siege
USER jboss
