#!/bin/bash
# Written by: Stan Towianski - Oct 2016
docker images
docker stop jm
docker rm jm
docker rmi jm-centos:1.0
docker images
