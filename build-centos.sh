#!/bin/bash

# Written by: Stan Towianski - Oct 2016

NEW_IMAGE_NAME=jmnew:1.0
JENKINS_VERSION=2.19.1
TIMEZONE="America/Detroit"

docker build -t $NEW_IMAGE_NAME --build-arg JENKINS_VERSION=$JENKINS_VERSION --build-arg TIMEZONE=$TIMEZONE -f ./Dockerfile.centos .

docker images
