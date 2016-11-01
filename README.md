# Centos version of the [Official Jenkins Docker image] (https://github.com/jenkinsci/docker) 

The Jenkins Continuous Integration and Delivery server.

This is a fully functional Jenkins server, based on the Long Term Support release.
[http://jenkins.io/](http://jenkins.io/).

The main purpose for me was I wanted to use Centos and I do not like the extremely minimal version of the standard jenkins image.
It has no Vi, no ifconfig, no route to edit or check when you have problems.

So, this starts with the standard centos images and updates it.
I also made this install Oracle Jdk 8 latest.
It installs an rpm version of Jenkins. This version does create standard init scripts for jenkins but I do not use them but still use the TINI init system.

# Build Centos Docker image

./build.sh

# Run Docker Jenkins image

./start-docker-jenkins.sh

# Kill and Remove Docker Jenkins image

./kill-rmi.sh


# Questions?

Jump on irc.freenode.net and the #jenkins room. Ask!

Stan Towianski

