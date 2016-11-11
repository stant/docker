#!/bin/bash

docker_image="jmsl-revive:1.0"
host_jenkins_home=/encrypt/data/jenkins_home2
daemon_flag="-d"
daemon_flag=""

/usr/bin/docker run $daemon_flag -p 8080:8080 --sysctl net.ipv6.conf.all.disable_ipv6=1 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $host_jenkins_home:/var/jenkins_home --env JENKINS_OPTS="--prefix=/jenkins" --name jmsl $docker_image

#  /bin/bash   to auto login

#  -e TZ='America/Detroit' -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro 

#  --net=host -p 192.168.27.91:8080:8080
#  --ip "192.168.27.120"
#  -m 0b