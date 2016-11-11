#!/bin/bash
# Written by: Stan Towianski - Oct 2016
/usr/bin/docker run -d -p 8080:8080 --sysctl net.ipv6.conf.all.disable_ipv6=1 -v /encrypt/data/jenkins_home:/var/jenkins_home --env JENKINS_OPTS=--prefix=/jenkins --name jm jm-centos:1.0
