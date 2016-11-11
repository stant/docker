#!/bin/bash

# Written by: Stan Towianski - Oct 2016

docker_image=jmnew:1.0
docker_image=jmsl:1.0
host_jenkins_home=/encrypt/data/jenkins_home
daemon_flag="-d"
daemon_flag=""

/usr/bin/docker run $daemon_flag -p 8080:8080 --sysctl net.ipv6.conf.all.disable_ipv6=1 -v $host_jenkins_home:/var/jenkins_home --env JENKINS_OPTS="--prefix=/jenkins" --name jm $docker_image

#  -e TZ='America/Detroit' -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro 

#  --net=host -p 192.168.1.9:8080:8080
#  --ip "192.168.1.12"
#  -m 0b