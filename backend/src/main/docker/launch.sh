#!/usr/bin/env bash

envconsul \
  -consul 192.168.12.34:8500 \
  -prefix registrator/unique_port \
  java \
    -Djava.security.egd=file:/dev/./urandom \
    -jar /tmp/app.war
