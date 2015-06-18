#!/bin/sh

CONSUL=$(route -n | awk '/UG / {print $2}')
APP="java \
      -Djava.security.egd=file:/dev/./urandom \
      -jar /tmp/app.war"

/usr/bin/curl \
  --silent \
  --output /dev/null \
  $CONSUL:8500

rc=$?

if [ $rc != 0 ]; then
  echo "WARNING! Consul not available, running locally."
  $APP
else
  /usr/bin/envconsul \
    -consul $CONSUL:8500  \
    -prefix registrator/unique_port \
    -upcase \
    $APP
fi
