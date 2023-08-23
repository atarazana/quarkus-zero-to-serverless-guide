#!/bin/bash

#############################################################################
# use java 8 if USE_JAVA8 is set to 'true', 
# use java 11 if USE_JAVA11 is set to 'true', 
# by default it is java 8
#############################################################################
if [ "${USE_JAVA11}" == "true" ] ; then
  sdk default java 11.0.15-tem
  echo "Java environment set to JAVA 11"
elif [ "${USE_JAVA17}" == "true" ] ; then
  sdk default java 17.0.3-tem
  echo "Java environment set to JAVA 17"
else
  echo "Java environment set to JAVA 11"
fi

exec "$@"