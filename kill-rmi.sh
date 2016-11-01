#!/bin/bash

# Written by: Stan Towianski - Oct 2016

docker images

docker stop jm
docker rm jm
docker rmi jmnew:1.0

docker images
