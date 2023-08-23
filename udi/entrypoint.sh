#!/bin/bash

#############################################################################
# use java 8 if USE_JAVA8 is set to 'true', 
# use java 11 if USE_JAVA11 is set to 'true', 
# by default it is java 8
#############################################################################
if [ "${USE_JAVA11}" == "true" ] ; then
  alternatives --set java-1.8.0-openjdk.x86_64
  echo "Java environment set to JAVA 11"
elif [ "${USE_JAVA17}" == "true" ] ; then
  alternatives --set java java-17-openjdk.x86_64
  echo "Java environment set to JAVA 17"
else
  echo "Java environment set to JAVA 11"
fi

exec "$@"